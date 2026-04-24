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

## Rust packages (`cargo` eclass)

- List all registry crates from `Cargo.lock` in the `CRATES` variable, sorted alphabetically.
- Exclude local workspace/path crates from `CRATES` — but DO include registry crates even if they
  share a name with the package (e.g., a Rust crate `text2num` depended on by Python package
  `text2num`).
- When patching `Cargo.toml` (e.g., changing features), the `Cargo.lock` must also be updated. Ship
  a pre-patched `Cargo.lock` in `files/` and copy it in `src_prepare()` if `cargo generate-lockfile`
  would change versions.
- Files in `files/` must be world-readable (`chmod 644`).

## Go packages (`go-module` eclass)

- Convert `go.sum` to `EGO_SUM` format: each line becomes a quoted string in a bash array.
- Sort `EGO_SUM` entries alphabetically.

## De-vendoring

- When a package vendors a library that is available as a separate package, prefer de-vendoring:
  remove the vendored copy in `src_prepare()`, fix imports with `sed`, and add the library as
  `RDEPEND`.

## CMake packages

- **Never allow `FetchContent`** to download dependencies at build time. Set cmake flags to disable
  it (e.g., `-DVCPKG_LIBCURL_DLSYM=OFF`) and use system libraries instead.
- If a project uses git submodules for headers, symlink or copy system-installed headers in
  `src_prepare()` rather than fetching the submodule.

## Packages with Cython extensions

- If the PyPI sdist does not include pre-generated `.c` files, add `DISTUTILS_EXT=1` and put
  `dev-python/cython[${PYTHON_USEDEP}]` in `BDEPEND`.
- If Cython source `cimport`s from other packages (e.g., `cimport blis.cy`), those packages must be
  in `DEPEND` (not just `RDEPEND`) so their `.pxd` files are available during compilation.

## Packages with mixed C library + Python module (e.g., vapoursynth)

- If upstream uses meson and provides both a C shared library and a Python extension module, use the
  `meson` eclass with `python-r1` — NOT `meson-python` via `distutils-r1`.
- `meson-python` (`DISTUTILS_USE_PEP517=meson-python`) builds a wheel, which only installs the
  Python module. It does NOT install C headers, shared libraries, or pkgconfig files.
- Use `-Dbuild_wheel=false` (or equivalent) so meson installs everything system-wide.

## Coordinated version bumps

- Some package ecosystems (e.g., spacy/thinc/confection/srsly/weasel) have tight inter-dependencies.
  When bumping one package, check that all packages in the ecosystem remain compatible.
- Keep only one version per package — the best compatible version. Do not keep old versions alongside
  new ones.

## Testing ebuilds

- `ebuild <path> manifest clean install` does NOT resolve dependencies. Use `emerge --oneshot` for
  packages whose `BDEPEND`/`DEPEND` packages may not be installed.
- When a package depends on another overlay package being installed first (e.g., vapoursynth plugins
  need vapoursynth), test in the correct order.

## Patches

- When updating a package, verify existing patches still apply by running
  `patch --dry-run -p1 < patchfile` against the new source.
- If a patch was applied upstream, remove it from the ebuild.
- If a `sed` pattern in `src_prepare()` no longer matches (e.g., a function signature changed),
  update it. Be careful that `sed` deletions don't break Python indentation — prefer replacing a
  line with `pass` over deleting it.

## Shell style in ebuilds

- Use `||` die pattern: `command || die`
- Use `edo` when available (from `edo` eclass) for commands that should be shown.
- Use double quotes around variable expansions.
- Follow shellcheck conventions (ebuilds are checked with shellcheck in CI).
