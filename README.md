# Strata - Public Docs

This repository contains all public devnet documentation related to [Strata](https://stratabtc.org).

## Getting Started

1. Clone this repository:

   ```bash
   git clone https://github.com/alpenlabs/docs.git
   ```

2. Install required dependencies.

   ```bash
   wget -qO- https://get.pnpm.io/install.sh | sh - # install pnpm
   pnpm install
   ```

3. Install `mkdocs-material`:

   ```bash
   pip install mkdocs-material
   ```

> [!NOTE]
> Alternatively you can use the `mkdocs-material` Docker image:
>
> ```bash
> docker pull squidfunk/mkdocs-material
> ```

## Making Changes

You can add your changes by editing/creating the markdown files in the
appropriate location in the repository. Make sure that you adhere to our
[style guide](./style-guide.md).

To preview your changes, run the following command:

```bash
mkdocs serve
```

> [!NOTE]
> If you are using the Docker image, you can run the following command:
>
> ```bash
> docker run --rm -u "$(id -u):$(id -g)" -v "$PWD":/docs -p 8000:8000 squidfunk/mkdocs-material
> ```

Your preview should be available at <http://localhost:8000>.

## Contributing

Before you push any changes or create a PR, please run the following:

```bash
# check that everything is formatted correctly
pnpm format:check

# check that there are no spelling errors
pnpm spell:check

# check that all documents follow the markdownlint rules
pnpm lint:check
```

Errors in any of the above commands will cause the CI to fail.
Formatting and lint issues can be fixed with the following:

```bash
pnpm format:fix

pnpm lint:fix
```

It is best to let your editor help you with these things so that you are not
caught by surprise when the CI checks run. This repo includes settings for
`vscode` that will help you get feedback from your editor as early as possible.
