# CLI usage

Strata comes with a Rust command line interface that allows you to interact
with the rollup and the

## Install it!

Ensure you have Cargo installed. If you don't have it, we recommend you
install it using [Rustup](https://rustup.rs).

```sh
cargo install --git https://github.com/alpenlabs/express -p strata-cli --locked --force
```

This will compile and install the binary into your system path. It may take a
few minutes depending on how powerful your hardware is.

## Use it!

The CLI is your entrypoint into developing with Strata.

Run `strata --help` to display the help message. If you're using a newer
version, the output might be slightly different.

```console
Usage: strata <command> [<args>]


A CLI for interacting with Alpen Labs' devnet signet and rollup.

Options:
  --help            display usage information

Commands:
  refresh           Runs any background tasks manually. Currently performs
                    recovery of old bridge in transactions
  drain             Drains the internal wallet to the provided signet and
                    rollup
                    addresses
  balance           Prints the wallet's current balance(s)
  backup            Prints a BIP39 mnemonic encoding the internal wallet's seed
                    bytes
  bridge-in         Bridge 10 BTC from signet to the rollup. If an address is
                    not provided, the wallet's internal rollup address will be
                    used.
  bridge-out        Bridge 10 BTC from the rollup to signet
  faucet            Request some bitcoin from the faucet
  send              Send some bitcoin from the internal wallet.
  receive           Prints a new address for the internal wallet
  change-password   Changes the seed's encryption password
  reset             Prints a BIP39 mnemonic encoding the internal wallet's seed
                    bytes
```

The CLI is composed of multiple commands. You can append `--help` to any one
to see more details about what the command does and what arguments it supports.

Available via commands are a Bitcoin signet wallet and an EVM-compatible Strata
rollup wallet, allowing you to use the Strata rollup without any other tools.
For example, the CLI can help you bridge bitcoin in and out of the rollup via
the `bridge-in` and `bridge-out` commands respectively.

When you first use a command, the CLI will ask you to create a new password to
encrypt the wallet's secret. If you're using Windows or macOS, `strata` will
store the encrypted secret in the operating system's keychain. On Linux, it
stores it in a file in the user's home directory.

### Request some bitcoin

Strata uses a custom signet which means Alpen Labs is the only miner. We have
a faucet that you can request bitcoin from via the CLI.

```
Usage: strata faucet [<address>] [--signet] [--rollup]

Request some bitcoin from the faucet

Positional Arguments:
  address           address that funds will be sent to. defaults to internal
                    wallet

Options:
  --signet          request bitcoin on signet
  --rollup          request bitcoin on rollup
  --help            display usage information
```

To receive ~10 BTC to test, run this command. If you haven't created a wallet
yet, this will prompt you for a password to encrypt a new one.

```
strata faucet --signet
```

Our signet uses accelerated block times of 30 seconds instead of the normal
Bitcoin mainnet's 10 minute interval to make the developer experience faster.
Wait for the transaction to be confirmed. Check by copying the transaction ID
provided by the CLI into [Alpen's signet explorer]().

You can also [check your balance](#check-your-balance).

### Check your balance

```
Usage: strata balance [--signet] [--rollup]

Prints the wallet's current balance(s)

Options:
  --signet          return the signet balance
  --rollup          return the rollup balance
  --help            display usage information
```

### Bridge some bitcoin to the rollup

After you've received your bitcoin, let's bridge some to Strata's rollup.

```
Usage: strata bridge-in [<rollup_address>]

Bridge 10 BTC from signet to the rollup. If an address is not provided, the
wallet's internal rollup address will be used.

Positional Arguments:
  rollup_address

Options:
  --help            display usage information
```

Currently, Strata is limited to bridging exactly 10 BTC for each bridge in. This
is likely to change after the devnet. To bridge 10 BTC from the internal signet
wallet to the internal rollup wallet, run this command.

```
strata bridge-in
```

If the funds are not available in your rollup wallet (check using
`strata balance --rollup`) after 1020 signet blocks, you can run the refresh
command to perform an autorecovery.

### Bridge that bitcoin back to the signet

To bridge 10 BTC from your rollup wallet to a signet address, use the following
command. If an address is provided, it must be a P2TR address. If an address
isn't provided, the CLI will send to a new signet address from its own wallet.

```
Usage: strata bridge-out [<p2tr_address>]

Bridge 10 BTC from the rollup to signet

Positional Arguments:
  p2tr_address      the signet address to send funds to. defaults to a new
                    internal wallet address

Options:
  --help            display usage information
```

### Send some bitcoin

```
Usage: strata send <network_type> <amount> <address>

Send some bitcoin from the internal wallet.

Positional Arguments:
  network_type      either "signet" or "rollup"
  amount            amount to send in sats
  address           address to send to

Options:
  --help            display usage information
```

You can send some bitcoin from the internal signet or rollup wallet via the
`strata send` command. The fee will be automatically determined, with options to
customize this coming in the future. If you want to drain your wallet, see the [drain command](#drain-the-wallet).

### Receive some bitcoin

```
Usage: strata receive [--signet] [--rollup]

Prints a new address for the internal wallet

Options:
  --signet          prints a new signet address
  --rollup          prints the rollup address
  --help            display usage information
```

For the rollup wallet, this will always return the same address as it doesn't
rotate accounts. The signet wallet will print a different address every time,
which is a
[BIP-086](https://github.com/bitcoin/bips/blob/master/bip-0086.mediawiki)
P2TR address. Signet addresses should not be reused.

### Change wallet password

```
Usage: strata change-password

Changes the seed's encryption password

Options:
  --help            display usage information
```

The change password command will load your existing seed, decrypt it and then
prompt you for a new password and overwrite the stored seed.

### Drain the wallet

Sometimes, you might want to want to send all of your funds to a single address.

To do this, run the `strata drain` command.

```
Usage: strata drain [-s <signet-address>] [-r <rollup-address>]

Drains the internal wallet to the provided signet and rollup addresses

Options:
  -s, --signet-address
                    a signet address for signet funds to be drained to
  -r, --rollup-address
                    a rollup address for rollup funds to be drained to
  --help            display usage information
```

Signet funds can only be drained to another signet address, and similarly for
rollup funds. This command will not implicitly bridge funds between the two
wallets.

### Refresh

To recover any failed/expired bridge in transactions, use the `refresh`
command. In the future, this command might also perform other actions, such as
automatically fee-bumping transactions you've previously made so they confirm
quicker.

```
Usage: strata refresh

Runs any background tasks manually. Currently performs recovery of old bridge in transactions

Options:
  --help            display usage information
```

Recovery of failed bridge-in transactions can be made 1018 signet blocks after
the bridge-in transaction was confirmed. With a 30 second block time, that's
about 8 hours 29 min.
