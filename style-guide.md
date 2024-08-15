# Documentation style guide

Alpen Labs documentation follow the following guidelines.
Please adhere to these guidelines when contributing to the documentation.

We are using a simple documentation framework called
[`mkdocs-material`](https://squidfunk.github.io/mkdocs-material/)
that is built on top of `Markdown` files.

## General guidelines

- **Clarity**: Write clear and concise documentation.
  Only add technical terms or jargons if they add clarity to the concept being
  described. At the same time, avoid skipping details for the sake of
  conciseness.
- **Consistency**: Ensure consistency in terms, formatting, and style throughout
  the documentation.
- **Accuracy**: Keep information accurate and up-to-date. Verify facts and
  details before including them in the documentation.
- **Audience**: Consider the target audience (beginners, advanced users,
  developers) and tailor the content accordingly.

## Language and tone

- **Voice**: Use active voice whenever possible.
  - Active: "The system processes the data."
  - Passive: "The data is processed by the system."
- **Tone**: Use a friendly and professional tone.
- **Grammar**: Use correct grammar and punctuation. Avoid contractions.
- **Terminology**: Use consistent terminology throughout the documentation.
  Define any technical terms or acronyms when first introduced.

## Bitcoin-related guidelines

- **Bitcoin**: The word "bitcoin" is not capitalized if referring to either
  the asset, the network, or the protocol. "Bitcoin" is capitalized if it is
  the first word in a sentence or if it is a proper noun that is part of something's
  name e.g. Bitcoin Core.
  - The ticker symbol for the native asset of the bitcoin blockchain is BTC.
- **Blockchain**: The word "blockchain" is not capitalized unless it is a proper
  noun part of something's name e.g. "Blockchain Inc."
  - The word “blockchain” is a one word (i.e. not “block chain”)
    [concrete noun](https://medium.com/@ryanshea/blockchain-terminology-a-grammar-usage-guide-ff54c95167bb)
    and should always be preceded by either a possessive noun, “a”, or “the” e.g.
    “bitcoin’s blockchain”, “a blockchain”, or “the blockchain”.
- **Decentralized applications**: The abbreviation of “decentralized application”
  is “dapp”. Not “DApp”, “dApp”, or “Ðapp”.
  - There is an ongoing debate over whether the term “decentralized application”
    is useful to begin with, at least in user-facing communications. In light of
    this, we should generally refer to a so-called "decentralized application" as
    an "app" or maybe more specifically "web app" or "mobile app" rather than a "dapp".
    If it is actually decentralized in some way, we can describe how in specific
    detail if the context calls for it.
- **Zero-knowledge**: The term "zero-knowledge" as in "zero-knowledge proof"
  (or "zk" for short) was originally defined as "those proofs that contain no
  additional knowledge other than the correctness of the proposition in question".
  However the term has since been used colloquially to describe any cryptosystem
  that enables sub-linear verification of computation using a validity proof,
  whether it is actually zero-knowledge or not. Due to this common usage and
  understanding we therefore accept the use of "zero-knowledge" or "zk" as
  synonymous with verifiable computation and may use these terms this same way
  throughout the documentation.

## File organization

- **Directory structure**: Organize documentation files in a logical and
  consistent directory structure.

  - Example:

    ```plaintext
    docs/
    ├── bridge-specs/
    │   ├── index.md
    │   ├── deposit-path.md
    │   └── withdrawal-path.md
    └── rollup-specs/
        ├── index.md
        ├── prover.md
        └── consensus-state-machine.md
    ```

- **File naming**: Use descriptive and consistent file names. Use hyphens to
  separate words.
  - Example: `basic-usage.md`
- **Index Files**: Use the index files (`index.md`) to provide the table
  of contents for the doc.

## Formatting

- **Commas**: Always use an Oxford comma (“Note that a, b, and c are…”).
- **Spelling**: Use American English spelling of a word when the spelling
  varies by locale.
- **Capitalization**: Page titles and headings should be in sentence case.
  This means that the first word is always capitalized and all other words
  except proper nouns and acronyms are lowercase.
- **Numbers**: Use numbers for numeric parameters, no matter how short the
  number e.g. 1 block, 5 seconds, 10 KB, etc.
- **Line Length**: Keep lines of text to a reasonable length (80 characters)
  for readability.
- **Headings**: Use hierarchical headings (H1, H2, H3, H4) to organize content.
  - H1: `# Title`
  - H2: `## Subtitle`
  - H3: `### Section`
  - H4: `#### Subsection`
- **Lists**:
  - Use unordered lists (`-`) for bullet points.
  - Use ordered lists (`1.`) for step-by-step instructions.
    Note that ordered lists should start from `1.` for each step.
    This ensures that the numbering is consistent across the document while also
    producing sane diffs in version control.
  - Lists should always be in alphabetical, numerical, or chronological order, unless
    there’s a good reason for them not to be.
- **Bullet points**
  - Use a period (full stop) after every bullet point that is a sentence.
  - Use a period after every bullet point that completes the introductory stem.
  - Use no punctuation after bullets that are fragment sentences and do not
    complete the stem.
  - Use all complete sentences or all fragments, but not a mixture.
  - Use no punctuation after bullets that only contain one word e.g. There are
    multiple implementations of bitcoin, including:
    - Bitcoin Core
    - bcoin
    - bitcoinj
    - btcd
    - libbitcoin
- **Emphasis**:
  - Use `_italic_` for emphasis.
  - Use `**bold**` for strong emphasis.
- **Blockquotes**: Use `>` for blockquotes to highlight important notes or
  quotes.
- **Tables**: Use tables for structured data.

  - Example:

    ```markdown
    | Header 1 | Header 2 |
    | -------- | -------- |
    | Cell 1   | Cell 2   |
    ```

- **Admonitions**: Use `!!!` for admonitions. Please refer to the
  [`mkdocs-material` documentation](https://squidfunk.github.io/mkdocs-material/reference/admonitions/).

  - Examples:

    ```markdown
    !!! note

        Useful information that users should know, even when skimming content.

    !!! info

        Additional information that provides context or clarification

    !!! tip

        Helpful advice for doing things better or more easily.

    !!! warning

        Urgent info that needs immediate user attention to avoid problems.

    !!! danger

        Advises about risks or negative outcomes of certain actions.
    ```

- **Equations**: Use `$` for inline equations and `$$` for block equations.
  You can also label them if needed for reference.
  Example:

  ```markdown
  There are $N^2$ different BitVM games.
  ```

  For block equations, use new-line separators.
  Example:

  ```markdown
  The parameters ought to have the following relationship:

  $$
    d < \frac{p + q}{2}
  $$
  ```

  Finally, here's how you can label equations:

  ```markdown
  $$
  \begin{equation}
    \int_0^\infty \frac{x^3}{e^x-1}\,dx = \frac{\pi^4}{15}
    \label{eq:sample}
  \end{equation}
  $$
  ```

- **Time format**: The format to use for dates is either YYYY-MM-DD if numeric
  (e.g 2020-12-31) or Month D(st)(th)(D, YYYY) if spelled out (e.g. January 1st
  or December 31, 2020).
  - Related: all times are communicated in UTC and specified as such to avoid
    the confusion of “Daylight Savings Time”, which is inconsistently implemented
    across the world
    ([even within the same country](https://en.wikipedia.org/wiki/Daylight_saving_time_in_the_United_States#Local_DST_observance))
    and is [generally a scourge on humanity](https://www.inc.com/jessica-stillman/experts-to-public-daylight-savings-time-is-a-434m-problem-we-could-easily-fix.html).
    An exception would be if there is an event being held locally in a specific
    time zone and there's no need to specify a time zone because all attendees will
    be in that time zone. In this case, the local time zone does not need to be
    specified unless the event is also being live-streamed so that people worldwide
    can watch online; here, both the local time zone and UTC time should be
    specified e.g. “17:00 EDT / 21:00 UTC”.

## Code and Commands

- **Inline Code**: Use backticks for inline code snippets.
  - Example: `inline code`
- **Code Blocks**: Use triple backticks for multi-line code blocks.
  Specify the language for syntax highlighting.
  Use annotations to provide context or explanations for code blocks.
  Annotations should be prefixed with language-specific comment characters,
  and should be followed by a footnote with the same id as the annotation.

  - Examples:

    ```python
    def example_fn():
        print("Hello, World!")
    ```

    ```rust
    fn example_fn() {
      println!("Hello, World!");
    }
    ```

    ```python
    # This code has an annotation at the end of the print function call.
    # You should add a footnote with the same id as the annotation, i.e. (1).
    def example_fn():
        print("Hello, World!") # (1)
    ```

- **Commands**: Prefix shell commands with `$` to distinguish them from code
  blocks.

  - Example:

    ```bash
    git clone https://github.com/your-user/your-repo.git
    ```

## Links and References

- **Internal Links**: Use relative links for internal references within the
  documentation.
  - Example: `[Section Title](#section-title)`
- **External Links**: Use absolute URLs for external references.
  - Example: `[External Resource](https://example.com)`
- **References**: Cite any external resources, documents, or articles
  appropriately.
- **Footnotes**: Use footnotes to add some extra relevant information. These can
  be used to display texts when hovering on certain words. Footnotes can be
  multiline as well. To start a new line, prefix it with two spaces.

  - Example:

    ```markdown
    At least one of the operators must be functional[^1] to prevent theft of
    funds from this address.

    [^1]:
        We use the term "functional" to describe an operator who is correctly
        following the protocol rules. An operator that is not functional is
        called "faulty".
    ```

## Images and Diagrams

- **Images**: Use clear and relevant images to support the text.
  Don't forget to add captions.

  - Example:

    ```markdown
    <figure markdown="span">
      ![Image title](https://dummyimage.com/600x400/){ width="300" }
      <figcaption>Image caption</figcaption>
    </figure>
    ```

- **Diagrams**: Use diagrams to illustrate complex concepts. `mkdocs-material`
  has support for [`mermaidjs`](https://mermaid.js.org/), which can be included
  with the following syntax:

  ```mermaidjs
  graph LR
  A[Start] --> B{Error?};
  B -->|Yes| C[Hmm...];
  C --> D[Debug];
  D --> B;
  B ---->|No| E[Yay!];
  ```

## Commit message format

Make your commit messages descriptive, concise and in the imperative form.
When in doubt, follow these excellent guides:

- [Write Better Commits, Build Better Projects](https://github.blog/2022-06-30-write-better-commits-build-better-projects/)
- [A Note About Git Commit Messages](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)

---

**Thank you for contributing to our documentation!
Adhering to this style guide helps maintain high-quality and consistent
documentation.**
