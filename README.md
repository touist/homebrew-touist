# homebrew-touist
Homebrew repo for the touist formula. Bottles (= pre-built binaries)
are built automatically by [![Build Status](https://travis-ci.org/touist/homebrew-touist.svg?branch=master)](https://travis-ci.org/touist/homebrew-touist).

To install `touist`:

    brew install touist/touist/touist

To push a new release:

    brew bump-formula-pr touist/touist/touist --url=https://github.com/touist/touist/archive/v3.4.1.tar.gz

See the gist [How-to-automate-build-bottles-your-tap.md](https://gist.github.com/maelvalais/068af21911c7debc4655cdaa41bbf092) for a thoughout explanation on how I did this full automation.
