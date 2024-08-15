# Introduction to Strata

!!! note

    Strata's devnet will be launching soon.
    To build on devnet,
    please apply using the devnet form on our [website](https://stratabtc.org/).

Strata gives developers the freedom to program nearly
any locking conditions for BTC imaginable,
limited only by the Strata block size and gas limits.
This enables developers to create new kinds of applications for BTC
with features such as:

- **New signature types**, "provide a valid `P-256` signature to authorize a transfer"

- **Vaults**, "transfers must wait `N` days after being initiated to be effectuated,
  and can be cancelled in the mean time"

- **Transfer limits**, "only `X%` or less of the current balance
  can be immediately with a single signature,
  larger amounts can only be transferred with multiple signatures"

- **Strong privacy**, "transaction details are end-to-end encrypted
  and verified using a zero-knowledge proof"

- **Economically secured zero-confirmation payments**,
  "if a double-spend from this sender is reported,
  the reporter gets to claim the sender's full wallet balance"

- **Financial transactions**,
  "if enough BTC is locked as collateral to maintain up
  to `X%` loan-to-value ratio,
  then up to N of this other asset can be borrowed"

... and many more possibilities.

Technically speaking,
**Strata is a work-in-progress EVM-compatible validity rollup on bitcoin**.
Let's break down what this means:

- **EVM-compatible**: The Strata block producer runs a client that is based on
  [Reth](https://github.com/paradigmxyz/reth),
  an Ethereum execution client.
  So far, no changes have been made that affect compatibility with the EVM spec.
  If you can deploy a smart contract to Ethereum,
  you can deploy it to Strata with no changes.

- **Validity rollup**: Every Strata state transition is proven to
  be valid using cryptographic validity proofs,
  which clients can use for fast, low-cost verification.

- **On bitcoin**: Strata uses bitcoin for consensus and data availability.
  When a Strata block gets confirmed on bitcoin,
  the only way to reorganize this block is to reorganize
  the bitcoin block that the Strata block was confirmed in.

You can find detailed technical information in the "How Strata Works"
section of this documentation.

!!! note

    During the devnet phase,
    Strata will be running on a private bitcoin signet,
    and will use signet blocks to store state commitments
    rather than the complete Strata state data,
    making Strata function more like a commit chain than a rollup.
    Support for full onchain data availability
    and for running Strata on bitcoin mainnet are planned for future releases.
