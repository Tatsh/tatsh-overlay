# tatsh-overlay

[![QA](https://github.com/Tatsh/tatsh-overlay/actions/workflows/qa.yml/badge.svg)](https://github.com/Tatsh/tatsh-overlay/actions/workflows/qa.yml)

This is stuff I make randomly. Usually updated every Sunday after 9 AM EST.

If you find a bug, please [file an issue](https://github.com/Tatsh/tatsh-overlay/issues/new).

## Installation

```shell
emerge app-eselect/eselect-repository
eselect repository enable tatsh-overlay
emerge --sync
```

## Only unmask packages you use from this repository

Based on [Masking installed but unsafe ebuild repositories](https://wiki.gentoo.org/wiki/Ebuild_repository#Masking_installed_but_unsafe_ebuild_repositories).

In `/etc/portage/package.mask/tatsh-overlay`, block all packages from this repository by default:

```plain
*/*::tatsh-overlay
```

In `/etc/portage/package.unmask/tatsh-overlay`, allow packages from this repository:

```plain
games-arcade/stepmania::tatsh-overlay
```

## Contributing

New packages are unlikely to be accepted unless they are related to emulators, reverse engineering,
etc. Wine-wrapper packages will not be accepted. Binary packages are only accepted if there is no
alternative.

For binary packages without source available, do not add the `-bin` suffix to the package name. If
providing a binary package that is unreasonable to build in the Portage environment for the time
being, add the `-bin` suffix to indicate so.

Please make a fork and a new branch, make your changes and then run the following steps:

1. `ebuild [name of ebuild] manifest clean install`

   If testing runtime is important (anything that is not a library), please also add `merge` to the
   above command and run some basic checks. For instance, with an emulator run a game that is known
   to be working in the official build.

2. `yarn && yarn qa`

   (Requires Node.js and Yarn to be installed.)

   Make sure the above passes completely.

3. `pkgdev commit --signoff` and fill in the required message if requested (do not change or remove
   the prefix). Even if not requested, add to the commit message as necessary.
