# Node types

Strata consists of different types of nodes,
each serving specific roles within the network.

- **Full node**: responsible for maintaining a local copy of
  and validating the entire Strata state
- **Sequencer node**: full node that has the additional responsibility
  of ordering transactions and producing new Strata blocks.
- **Bridge node**: full node that has the additional responsibility
  of facilitating the transfer of assets between bitcoin and Strata.

## Node comparison table

<!-- markdownlint-disable line-length -->

| Network                | Feature                                            | Full node                  | Sequencer node             | Bridge node                |
| :--------------------- | :------------------------------------------------- | -------------------------- | -------------------------- | -------------------------- |
| **Strata**             | **storage** of blocks and state                    | :material-check:{ .green } | :material-close:{ .red }   | :material-close:{ .red }   |
| **Strata**             | **validation** of incoming blocks and transactions | :material-check:{ .green } | :material-close:{ .red }   | :material-close:{ .red }   |
| **Strata**             | **RPC**-endpoint                                   | :material-check:{ .green } | :material-close:{ .red }   | :material-close:{ .red }   |
| **Strata**             | **relay** of transactions and blocks               | :material-check:{ .green } | :material-check:{ .green } | :material-close:{ .red }   |
| **Strata**             | **sequence** of incoming transactions              | :material-close:{ .red }   | :material-check:{ .green } | :material-close:{ .red }   |
| **Strata**             | **construction** of new blocks                     | :material-close:{ .red }   | :material-check:{ .green } | :material-close:{ .red }   |
| **Strata**             | **broadcast** of new blocks                        | :material-close:{ .red }   | :material-check:{ .green } | :material-close:{ .red }   |
| **Strata**             | **execution** of incoming transactions             | :material-check:{ .green } | :material-check:{ .green } | :material-close:{ .red }   |
| **Bitcoin**            | **writing** of batch data                          | :material-close:{ .red }   | :material-check:{ .green } | :material-close:{ .red }   |
| **Bitcoin**            | **monitoring** of deposit transactions             | :material-close:{ .red }   | :material-close:{ .red }   | :material-check:{ .green } |
| **Bitcoin**            | **processing** of withdrawal requests              | :material-close:{ .red }   | :material-close:{ .red }   | :material-check:{ .green } |
| **Bitcoin**/**Strata** | **Ensuring** secure BTC transfers                  | :material-close:{ .red }   | :material-close:{ .red }   | :material-check:{ .green } |

<!-- markdownlint-enable line-length -->

## Full node

A Strata full node is responsible for maintaining
and validating the entire state of the Strata chain.

**Key features**:

- Stores the complete history of Strata blocks and state.
- Validates incoming Strata blocks and transactions.
- Serves RPC requests for chain data.
- Participates in the network by relaying transactions and blocks.

## Sequencer node

A sequencer node is a specialized full node that has
the additional responsibility of ordering transactions
and producing new Strata blocks.

**Key features**:

- All features of a _full node_.
- Receives and orders incoming transactions.
- Executes transactions to produce new Strata blocks.
- Interacts with the bitcoin node write batch metadata to bitcoin.
- Serves Strata blocks to other full nodes via RPC.

## Bridge node

A bridge node facilitates the transfer of assets between
bitcoin and Strata.

**Key features**:

- Monitors bitcoin for deposit transactions.
- Processes Strata withdrawal requests.
- Interacts with both bitcoin and Strata to ensure secure BTC transfers.

## Key differences between node types

<!-- prettier-ignore-start -->

1. **Block production**:
    - _Only_ sequencer nodes produce and relay new Strata blocks.
    - Full nodes and bridge nodes validate blocks
      but do _not_ produce or relay them.
2. **Network interactions**:
    - Sequencer nodes have the most complex network interactions,
      dealing with both Strata transaction intake and bitcoin checkpoints.
    - Bridge nodes interact extensively with both bitcoin
      and Strata for BTC transfers.
    - Full nodes primarily interact within the Strata network.
3. **Resource requirements**:
    - Sequencer nodes typically require the most resources
      due to their block production responsibilities.
    - Full nodes require significant storage for the entire state history.
    - Bridge nodes require reliable connections to both bitcoin and Strata.

<!-- prettier-ignore-end -->
