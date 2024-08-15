alias s := serve

# List everything
default:
  @just --list

# Serve the site localling
serve:
    @echo "Serving the site locally"
    @echo "If this fails you might need either to install mkdocs-material or run 'just serve-docker' instead"
    mkdocs serve

# Serve the site locally using Docker
serve-docker:
    @echo "Serving the site locally using Docker"
    docker run --rm -u "$(id -u):$(id -g)" -v "$PWD":/docs -p 8000:8000 squidfunk/mkdocs-material

# Make everything ready for a PR
pr:
    @just format-check
    @just lint-check
    @just spell-check
    @echo "PR checks complete!"

# Check for spelling errors
spell-check:
    @echo "Checking for spelling errors"
    pnpm spell:check

# Add a word to the dictionary
spell-add *WORDS:
    @echo "Adding {{ WORDS }} to the dictionary"
    for word in {{ WORDS }}; do echo $word >> project-words.txt; done

# Sort the dictionary
spell-sort:
    @echo "Sorting the dictionary"
    sort -o project-words.txt project-words.txt

# Check for formatting errors
format-check:
    @echo "Checking for formatting errors"
    pnpm format:check

# Fix formatting errors
format-fix:
    @echo "Fixing formatting errors"
    pnpm format:fix

# Check for lint errors
lint-check:
    @echo "Checking for lint errors"
    pnpm lint:check

# Fix lint errors
lint-fix:
    @echo "Fixing lint errors"
    pnpm lint:fix

# Install pnpm
pnpm-install:
    @echo "Installing pnpm"
    wget -qO- https://get.pnpm.io/install.sh | sh

# Install NPM dependencies
npm-install:
    @echo "Installing NPM dependencies"
    pnpm install

# Clean the NPM cache
npm-clean:
    @echo "Cleaning NPM cache"
    rm -rf node_modules/ .pnpm-store/
