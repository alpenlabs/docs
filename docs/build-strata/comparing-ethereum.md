# Comparing Strata and Ethereum

## EVM compatibility

Strata is an EVM-compatible blockchain.
The execution client used by the Strata block producer is based on reth
and is fully compatible with the EVM spec.
During the devnet phase, Strata can be considered a Type 1 zkEVM.

!!! note

    In a future release,
    Strata developers plan to introduce changes
    that will result in a Type 2.5 zkEVM rating.
    Watch the Strata [issues repo](https://github.com/alpenlabs/strata/issues)
    to stay up to date with proposed consensus changes.

## Blockchain functionality

Comparing differences in how Strata and Ethereum functionally operate:

<!-- markdownlint-disable line-length -->

|                  | Strata                                                                                                 | Ethereum       |
| ---------------- | ------------------------------------------------------------------------------------------------------ | -------------- |
| Consensus:       | Proof of Work                                                                                          | Proof of Stake |
| Gas asset:       | BTC                                                                                                    | ETH            |
| Block gas limit: | 8,000,000                                                                                              | 30,000,000     |
| Block time:      | ~5s                                                                                                    | ~12s           |
| Finality:        | Probabilistic, blocks are confirmed in<br> batches on a private bitcoin signet<br> about once per hour | ~15m           |

<!-- markdownlint-enable line-length -->
