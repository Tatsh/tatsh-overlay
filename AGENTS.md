# Agents

## Project overview

This is `tatsh-overlay`, a personal Gentoo ebuild overlay maintained by @Tatsh. It provides
ebuilds across categories like emulators, Python packages, games, media tools, and system
utilities. The overlay masters are `gentoo` and `guru`.

## Repository structure

- `<category>/<package>/` - ebuild packages following Gentoo repository layout
- `eclass/` - custom eclasses: `libretro-core`, `libretro`, `mpv-plugin`, `mpv-shader`, `yarn`
- `metadata/` - repository metadata (`layout.conf`, etc.)
- `profiles/` - custom categories (`mpv-plugin`, `mpv-shader`), `use.local.desc`
- `scripts/` - helper scripts (Python/Bash) for automation (livechecks, metadata generation, etc.)
- `licenses/` - custom license files not in the main Gentoo tree

## Key technologies

- **Ebuilds**: Bash scripts using EAPI 8, Gentoo package manager specification.
- **Eclasses**: Reusable ebuild logic (like libraries for ebuilds).
- **QA tooling**: shellcheck, mypy, ruff, pyright, cspell, prettier, markdownlint-cli2, yapf.
- **Package managers**: Yarn (Node.js dev tooling), Poetry (Python dev tooling).
- **CI**: GitHub Actions (`qa.yml` runs all linters, `codeql.yml` for security).

## Commit message format

Follow `pkgdev commit` conventions:

- `<category>/<package>: <action>` — e.g., `dev-python/foo: new package, add 1.0.0`
- Common actions: `new package, add <version>`, `add <version>, drop <old>`,
  `disable py3.10`, `make fetch restriction selective`.
- Dependabot-style for dev deps: `build(deps-dev): bump <pkg> from X to Y`.

## QA

Run `yarn && yarn qa` to check everything. This runs shellcheck on all ebuilds/eclasses/scripts,
mypy and ruff on Python scripts, spell checking, and formatting checks.

## Contributing rules

- New packages should relate to emulators, reverse engineering, etc.
- No Wine-wrapper packages.
- Binary packages only if no source alternative exists.
- Binary packages without source: no `-bin` suffix.
- Binary packages unreasonable to build in Portage: add `-bin.

## Ebuild conventions

See [ebuild rules](.claude/rules/ebuild.md) for detailed ebuild writing rules.
