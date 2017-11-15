# homebrew-touist

Homebrew tap for the the `touist` release as well as some QBF and SAT
solvers that I wanted to make available more easily.

To install `touist`:

    brew install touist/touist/touist

To push a new release:

    brew bump-formula-pr touist/touist/touist --url=https://github.com/touist/touist/archive/v3.4.4.tar.gz

To create a new formula:

    brew create --tap touist/touist https://github.com/touist/touist/archive/v3.4.4.tar.gz

## Pre-built binaries on Bintray

Bottles (= pre-built binaries) for linux (x86\_64) and macOS are built
automatically by [Travis CI][travis].

[![Build status on Travis CI][travis-logo]][travis]

[travis]: https://travis-ci.org/touist/homebrew-touist
[travis-logo]: https://travis-ci.org/touist/homebrew-touist.svg?branch=master

See the gist [How-to-automate-build-bottles-your-tap.md](https://gist.github.com/maelvalais/068af21911c7debc4655cdaa41bbf092) for a thoughout explanation on how I did this full automation.
