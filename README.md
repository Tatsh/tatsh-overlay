# tatsh-overlay

[![License](https://img.shields.io/github/license/Tatsh/tatsh-overlay)](https://github.com/Tatsh/tatsh-overlay/blob/master/LICENSE)
[![CodeQL](https://github.com/Tatsh/tatsh-overlay/actions/workflows/codeql.yml/badge.svg)](https://github.com/Tatsh/baldwin/actions/workflows/codeql.yml)
[![QA](https://github.com/Tatsh/tatsh-overlay/actions/workflows/qa.yml/badge.svg)](https://github.com/Tatsh/tatsh-overlay/actions/workflows/qa.yml)
[![GitHub Pages](https://github.com/Tatsh/tatsh-overlay/actions/workflows/pages/pages-build-deployment/badge.svg)](https://tatsh.github.io//re3-installer/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Stargazers](https://img.shields.io/github/stars/Tatsh/baldwin?logo=github&style=flat)](https://github.com/Tatsh/baldwin/stargazers)

[![@Tatsh](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fpublic.api.bsky.app%2Fxrpc%2Fapp.bsky.actor.getProfile%2F%3Factor%3Ddid%3Aplc%3Auq42idtvuccnmtl57nsucz72%26query%3D%24.followersCount%26style%3Dsocial%26logo%3Dbluesky%26label%3DFollow%2520%40Tatsh&query=%24.followersCount&style=social&logo=bluesky&label=Follow%20%40Tatsh)](https://bsky.app/profile/Tatsh.bsky.social)
[![Mastodon Follow](https://img.shields.io/mastodon/follow/109370961877277568?domain=hostux.social&style=social)](https://hostux.social/@Tatsh)

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
