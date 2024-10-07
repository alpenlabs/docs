# Comparing Strata and Ethereum

## EVM compatibility

Strata is an EVM-compatible blockchain.
The execution client used by the Strata block producer is based on Reth
and is fully compatible with the EVM spec up to the 
[Shanghai](https://github.com/ethereum/execution-specs/blob/master/network-upgrades/mainnet-upgrades/shanghai.md) 
release. During the devnet phase, Strata can be considered a Type 1 zkEVM.

!!! note

    In a future release,
    Strata developers plan to introduce changes
    that will result in a Type 2.5 zkEVM rating.

## Blockchain functionality

Comparing differences in how Strata and Ethereum functionally operate:

<!-- markdownlint-disable line-length -->

|                  | Strata Devnet                                                                                          | Ethereum       |
| ---------------- | ------------------------------------------------------------------------------------------------------ | -------------- |
| Consensus:       | Proof of Authority                                                                                     | Proof of Stake |
| Gas asset:       | BTC                                                                                                    | ETH            |
| Block gas limit: | 15,000,000                                                                                             | 30,000,000     |
| Block time:      | ~5s                                                                                                    | ~12s           |
| Finality:        | Probabilistic, blocks are confirmed in<br> batches on a private bitcoin signet<br> about once per hour | ~15m           |

<!-- markdownlint-enable line-length -->
