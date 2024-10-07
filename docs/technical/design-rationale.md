# Strata design rationale

In designing Strata,
we adopted a structure inspired by Ethereum's post-merge (formerly "2.0") architecture,
where each full node consists of two distinct components:
an **execution client** and a **consensus client**.
In Ethereum, the consensus client manages Proof of Stake (PoS) consensus,
including proposer selection and block finalization,
while the execution client is responsible for transaction execution using
the EVM interpreter and processing user-facing application-level queries.
These two clients communicate via the **Engine API**,
which allows them to exchange necessary information,
such as when the consensus client requests
the execution client to process a block.

Similarly, the Strata network is divided into two blockchains,
with each full node able to run a client for each of the following layers:

1. **Execution layer**: Handles transaction execution and chain state.
1. **Orchestration layer**
   (our version of Ethereum's consensus layer):
   Coordinates various specialized tasks related to bitcoin interactions,
   bridge operations, decentralized sequencing,
   and other Strata-specific operations.

In our architecture, the execution layer is an EVM environment implemented
using a fork of Reth,
while the orchestration layer is a new blockchain tailored to implement
Strata's rollup design and support its consensus requirements.
The two layers communicate via a slightly modified version of the Engine API,
which we extended to handle specific features like bridge transfers in/out of
the execution layer.
This modification was necessary as Ethereum's Engine API doesn't natively support
this functionality.

## Advantages of separation

By following Ethereum's well-thought-out approach to separating execution and orchestration,
Strata gains important advantages:

- **Modularity and specialization**:
  The execution and orchestration layers have distinct, specialized functions.
  This separation allows them to be developed, maintained,
  and iterated upon independently.
  For example, improvements to the orchestration layer's coordination logic
  can be made without impacting the execution layer, and vice versa.

- **Future support for multiple execution environments**:
  This separation allows us to support different execution environments in the future,
  each conforming to our modified Engine API.
  This means a future with different kinds of execution layers
  (eg. WASM-based, privacy-focused, etc.), on top of the orchestration layer,
  all having the ability to easily and trustlessly interoperate.

## Why we chose a custom solution over existing SDKs

We initially started development with an existing SDK but,
after several months, chose to start over from scratch due to
the challenges of relying on third-party tools.
While SDKs like **Sovereign SDK**, **Rollkit**,
and **OP Stack** could have sped up early development,
we opted to build a custom orchestration layer for several key reasons:

- **Complete control and flexibility**:
  Our main objective was to retain full control over the development of
  our orchestration and consensus logic.
  This allows us to introduce advanced features—such as instant preconfirmations,
  slashing for misbehavior, interoperability,
  and volition-style hybrid DA—on our own timeline,
  without being restricted by external SDK limitations.
  While pre-built SDKs provide basic functionalities,
  extending beyond those often requires coordination with external teams,
  which may create friction if the roadmaps are misaligned.
  Building our own solution ensures we can evolve our architecture independently.
- **Avoiding development bottlenecks**:
  During our initial development with a third-party SDK,
  we encountered multiple limitations that slowed our progress.
  In one instance, something as simple as retrieving
  the status of an EVM transaction on the bitcoin chain required suboptimal workarounds
  due to the difficulty in modifying the SDK's interface.
  Although the SDK team eventually supported us
  in making SDK changes or providing better solutions,
  relying on external fixes introduced delays.
  By building our orchestration layer from scratch,
  we eliminate these bottlenecks,
  enabling faster iterations and more efficient development.
- **Limitations of current SDKs for our use case**:
  Most of the available third-party SDKs, mostly by design,
  lack native support for rollups with bitcoin as the settlement layer.
  OP Stack, for instance, is centered on optimistic rollups
  and fault proofs on Ethereum. Sovereign SDK and Rollkit, while flexible,
  are built around generic rollup use cases and typically integrate with EVM
  or Cosmos-like ecosystems.
  In contrast, Strata's architecture is specifically designed for a rollup
  that settles to bitcoin and includes a validating bridge to and from bitcoin.
  This requires unique design considerations,
  such as accommodating bitcoin's UTXO transaction model,
  limited scripting capabilities, and probabilistic settlement.
  Our bitcoin-centric approach enabled us to easily incorporate a
  BitVM-based bridge from the outset and provides flexibility to
  integrate future bitcoin-specific innovations more easily.

---

By building our orchestration layer from scratch,
we not only gain complete control over how we manage consensus,
bridge operations, and interactions with bitcoin,
but we also position Strata for future extensibility without being locked into
the limitations of existing SDKs or external dependencies.
We do learn from the existing SDKs and borrow ideas where we can,
but our custom solution allows us flexibility and specificity for our use case.
