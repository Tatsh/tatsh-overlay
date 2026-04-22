---
description: Rules for writing and modifying Gentoo ebuilds in this overlay.
globs: '**/*.ebuild'
---

# Ebuild rules

These conventions take priority over general Gentoo conventions when they differ.

## EAPI

- Always use `EAPI=8` (no quotes around the value).

## Copyright header

- Format: `# Copyright <year> Gentoo Authors`
- Use the current year for new ebuilds.
- Use `# Distributed under the terms of the GNU General Public License v2` as the second line.
- No blank line between the copyright and the license line.

## Variable ordering

Follow this order in ebuilds:

1. `EAPI`
2. Build system / Python variables (`DISTUTILS_USE_PEP517`, `PYTHON_COMPAT`, etc.)
3. `inherit` line
4. Live ebuild conditionals (`EGIT_REPO_URI` etc.) if applicable
5. `DESCRIPTION`
6. `HOMEPAGE`
7. `SRC_URI` (if not using `pypi` eclass which sets it automatically)
8. `LICENSE`
9. `SLOT`
10. `KEYWORDS`
11. `IUSE`
12. `REQUIRED_USE`
13. Dependencies: `BDEPEND`, `DEPEND`, `RDEPEND`
14. Phase functions

## `PYTHON_COMPAT`

- Use brace expansion: `python3_{11..14}` (range) or `python3_1{0,1,2,3,4}` (list).
- Prefer the `{start..end}` range syntax for contiguous versions.
- Only include Python versions the package actually supports.

## `KEYWORDS`

- New packages use `~amd64` (testing keyword only).
- Do not add keywords for architectures you cannot test.

## `SLOT`

- Default to `SLOT="0"` unless the package genuinely needs slotting.

## Dependencies

- Use `>=` version constraints when upstream specifies minimum versions.
- Always include `[${PYTHON_USEDEP}]` for Python library dependencies in `RDEPEND`.
- Sort dependencies alphabetically within each dependency variable.

## `HOMEPAGE`

- For packages with multiple relevant URLs, use a multi-line format:

  ```bash
  HOMEPAGE="
      https://example.com/docs/
      https://github.com/org/repo
      https://pypi.org/project/name/
  "
  ```

- For packages with a single URL, use single-line format.

## Python packages (`distutils-r1`)

- Inherit `distutils-r1` and `pypi` (when the package is on PyPI).
- Set `DISTUTILS_USE_PEP517` to the actual build backend (`hatchling`, `setuptools`, `uv-build`,
  etc.).
- Use `distutils_enable_tests pytest` when the package has pytest-based tests.
- Do not define `src_test()` if `distutils_enable_tests` suffices.

## `metadata.xml`

Every package must have a `metadata.xml` with:

- Maintainer: `audvare@gmail.com` / `Andrew Udvare`
- `<upstream>` with `<remote-id>` when applicable (e.g., `type="pypi"`, `type="github"`).
- Use tabs for indentation in XML files.

## Manifest

After creating or modifying an ebuild, run `ebuild <path> manifest` to generate/update the
Manifest file. Do not manually edit Manifest files.

## Naming

- Follow Gentoo naming conventions for categories and package names.
- For binary packages without source available, do not add `-bin` suffix.
- For binary packages that are unreasonable to build in Portage, add `-bin` suffix.

## Shell style in ebuilds

- Use `||` die pattern: `command || die`
- Use `edo` when available (from `edo` eclass) for commands that should be shown.
- Use double quotes around variable expansions.
- Follow shellcheck conventions (ebuilds are checked with shellcheck in CI).
