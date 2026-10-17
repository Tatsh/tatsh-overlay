# tatsh-overlay

[![License](https://img.shields.io/github/license/Tatsh/tatsh-overlay)](https://github.com/Tatsh/tatsh-overlay/blob/master/LICENSE)
[![Gentoo](https://img.shields.io/badge/Gentoo-tatsh--overlay-54487A?logo=gentoo&logoColor=white)](https://repos.gentoo.org/#tatsh-overlay)
[![CodeQL](https://github.com/Tatsh/tatsh-overlay/actions/workflows/codeql.yml/badge.svg)](https://github.com/Tatsh/tatsh-overlay/actions/workflows/codeql.yml)
[![QA](https://github.com/Tatsh/tatsh-overlay/actions/workflows/qa.yml/badge.svg)](https://github.com/Tatsh/tatsh-overlay/actions/workflows/qa.yml)
[![GitHub Pages](https://github.com/Tatsh/tatsh-overlay/actions/workflows/pages/pages-build-deployment/badge.svg)](https://tatsh.github.io/tatsh-overlay/)
[![Dependabot](https://img.shields.io/badge/Dependabot-enabled-blue?logo=dependabot)](https://github.com/dependabot)
[![Stargazers](https://img.shields.io/github/stars/Tatsh/tatsh-overlay?logo=github&style=flat)](https://github.com/Tatsh/tatsh-overlay/stargazers)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Tatsh/tatsh-overlay/master.svg)](https://results.pre-commit.ci/latest/github/Tatsh/tatsh-overlay/master)
[![Prettier](https://img.shields.io/badge/Prettier-black?logo=prettier)](https://prettier.io/)
[![ShellCheck](https://img.shields.io/badge/ShellCheck-black?logo=gnubash)](https://www.shellcheck.net/)
[![Yarn](https://img.shields.io/badge/Yarn-black?logo=yarn)](https://yarnpkg.com/)

[![@Tatsh](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fpublic.api.bsky.app%2Fxrpc%2Fapp.bsky.actor.getProfile%2F%3Factor%3Ddid%3Aplc%3Auq42idtvuccnmtl57nsucz72%26query%3D%24.followersCount%26style%3Dsocial%26logo%3Dbluesky%26label%3DFollow%2520%40Tatsh&query=%24.followersCount&style=social&logo=bluesky&label=Follow%20%40Tatsh)](https://bsky.app/profile/Tatsh.bsky.social)
[![Libera.Chat](https://img.shields.io/badge/Libera.Chat-Tatsh-black?logo=liberadotchat)](irc://irc.libera.chat/Tatsh)
[![Mastodon Follow](https://img.shields.io/mastodon/follow/109370961877277568?domain=hostux.social&style=social)](https://hostux.social/@Tatsh)

This is stuff I make randomly. Usually updated every Sunday after 9 AM EST.

If you find a bug, please [file an issue](https://github.com/Tatsh/tatsh-overlay/issues/new).

## Installation

This overlay builds on the [GURU](https://wiki.gentoo.org/wiki/Project:GURU) and
[Pentoo](https://www.pentoo.org/) overlays, and some packages here depend on packages only they
provide, so enable all three:

```shell
emerge app-eselect/eselect-repository
eselect repository enable guru pentoo tatsh-overlay
emaint sync -a
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

See [CONTRIBUTING.md](CONTRIBUTING.md).
