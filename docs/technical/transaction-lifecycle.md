# Transaction lifecycle

This document describes the journey of Strata transactions
from initiation to finalization.

## Transaction initiation and propagation

For devnet, Strata supports both Externally Owned Account (EOA) transactions
and account abstraction transactions (referred to as UserOperations)
as defined in ERC-4337.
EOA transactions can be initiated by users through any EVM-compatible wallet
that is connected to a Strata full node.
For account abstraction, we provide a bundler that accepts UserOperations
and relays them to a full node we have deployed.
On devnet, each full node is directly connected to a full node run by Alpen Labs,
which in turn is connected to the sequencer (also run by Alpen Labs).
This setup helps reduce propagation time,
given the relatively small number of full nodes expected.
Ultimately, all user transactions reach the sequencer through
this full node.

## Block building

The sequencer orders the EVM transactions received based on
the default algorithm used by Reth,
which is to prioritize the transactions with higher effective gas price,
respecting the account nonce ordering (ascending).
A block is constructed every 5 seconds, and it includes:

- A header with metadata (timestamp, block number, etc.)
- An L1 segment (information from the bitcoin chain)
- An execution segment (includes the actual EVM transactions and related info)

The block is executed against the current Strata chain state,
during which the pending withdrawals and deposits are processed
and the chain state is updated.
The chain state primarily includes:

- EVM state
- Strata’s view of the bitcoin state
  (eg. current "safe" bitcoin block, blocks that may reorg, etc.)
- List of current bridge operators
- Pending deposit and withdrawal info
- Auxiliary info about the Strata chain e.g. latest Strata block,
  current slot and checkpoint period, etc. More about checkpointing below.

After the block is executed and verified, the block is added to the blockchain
and is relayed to the prover and full nodes, who are all polling for new blocks.

## Batch building

A batch represents a collection of blocks associated with a single checkpoint,
which includes a proof of state transition and state commitments,
written to bitcoin in a bitcoin transaction.
The process of building a new batch checkpoint begins when the checkpoint for
the previous batch is detected on bitcoin.
The first block of the new batch follows immediately after
the final block of the previous batch - this applies to both the Strata
and bitcoin batches.
The final block in the Strata batch is chosen to be
the latest block in the Strata chain,
while the final block in the bitcoin batch is the most recent "safe" block on
the bitcoin chain as seen by the sequencer.
A safe block is one that has been sufficiently buried in the bitcoin chain
to be resistant to reorganization.

Once the sequencer decides on the ranges for the new batch checkpoint,
the prover begins constructing
an aggregated proof of state transition for that batch.
Once the proof is ready, it is prepared to be written to bitcoin,
along with the checkpoint information.

## Proving

The prover starts proving the state transition for a Strata block as soon as
it is constructed by the sequencer,
retrieving all the inputs necessary for proof generation from the sequencer.
Since block construction by the sequencer is faster than
the proof generation for a block,
proof generation of multiple blocks happen in parallel.
When it is time to construct a proof for a new batch,
the prover retrieves previous proof information,
the new batch checkpoint information, and the relevant bitcoin chain,
and the prover starts two parallel processes:

1. constructing a recursive proof in proper order from
   the individual state transition proofs of
   each Strata block generated for this batch, and
2. constructing a proof by reading the bitcoin chain for the given range,
   verifying its validity,
   and verifying that all relevant transactions in the bitcoin chain,
   such as deposits and the previous batch proof, are included in the Strata chain.
   Both of these proofs are then recursively combined to create the batch proof.

The batch proof proves the following:

- The input bitcoin chain is valid and corresponds to the range of this batch.
- Every transaction in the bitcoin chain was scanned and all
  the relevant transactions
  (such as the previous checkpoint transaction and deposit transactions)
  are properly extracted.
- The previous batch proof in the extracted checkpoint is valid.
- All deposits initiated on bitcoin are included in the Strata batch.
- The current batch starts immediately after the last block of the previous batch.
- Execution of the Strata blocks in this batch produces a valid state transition.

The batch proof is recursive,
so by verifying the latest batch proof a client can verify that
the Strata state transitions from genesis to the latest block included
in the batch are valid.
This batch proof is passed to the sequencer for writing to bitcoin.

## Batch checkpoint

Once the batch proof is ready,
the proof is included in the checkpoint which is signed by the sequencer,
compressed, and serialized into bytes.
The sequencer then creates bitcoin transactions with
an [envelope](https://docs.ordinals.com/inscriptions.html) that contains
the signed checkpoint data along with Strata chain information such as
the blockchain name and version.

The transactions are then broadcast to the bitcoin network
and eventually confirmed in a bitcoin block.

### Batch finalization

Once the bitcoin block containing the batch checkpoint
is sufficiently buried in the blockchain,
full nodes consider the Strata batch committed to in the checkpoint,
and all transactions in that batch, to be finalized.
