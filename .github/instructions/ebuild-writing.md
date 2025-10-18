---
applyTo: '**/*.ebuild'
---

<!-- markdownlint-disable no-hard-tabs -->

# Ebuild Writing Guidelines

## General Structure

- Use `EAPI=8` for new ebuilds.
- Use tabs for indentation, never spaces.
- Follow Gentoo ebuild conventions and PMS (Package Manager Specification).

## Patching and configuration

- Use the `PATCHES` array except in very special cases.
- Use the `DOCS` array except in very special cases.
- Do not add `CONTRIBUTING`, `LICENSE`, etc to `DOCS`.
- If an application has an automatic updater feature and this can be easily disabled at build time,
  do so.
- Do not leave empty variables in the ebuild.

## Variable Order

```bash
EAPI=8

# Inherit eclasses
inherit cmake

# Package metadata
DESCRIPTION="Short description"
HOMEPAGE="https://example.com"
SRC_URI="https://github.com/user/project/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="optional-feature"

# Dependencies
RDEPEND="dev-libs/libd
	dev-libs/libfoo"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/a-special-developer-tool
	virtual/pkgconfig"
```

## Phase Functions

- Always use `|| die` after commands that can fail, when the identifier is not from an eclass or
  Portage.
- Call `default` or the equivalent function from the eclass at the end of phase functions when
  appropriate. If multiple eclasses are being used, it may be appropriate to call all of the
  equivalent functions.
- Use `${S}`, `${D}`, `${WORKDIR}`, `${P}`, `${PN}`, `${PV}` variables.

```bash
inherit cmake

...

src_prepare() {
  do-something-special
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_FEATURE=$(usex optional-feature)
    -DOTHER_FEATURE=ON
    -DENABLE_AUTOMATIC_UPDATER=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
}
```

## Dependencies

- `RDEPEND`: Runtime dependencies. Most often these are packages that are not explicitly linked to
  (such as when a package spawns an executable rather than linking to a library). This also applies
  to most Python/Ruby/etc libraries since that kind of code is not linked like C/C++ code.
- `DEPEND`: Link-time dependencies (usually same as `RDEPEND`).
- `BDEPEND`: Build tools (special tools that do not get added automatically by an eclass, etc.).

## USE Flags

- Use `usex` for boolean flags: `$(usex flag ON OFF)`.
- Use `use` for conditional logic: `use flag && doins file`.

## Installation

- Use `doins`, `dobin`, `dodoc`, `doman`, and `einstalldocs` helpers.
- Never use `make install` directly. Use eclass functions.
- Install to `${D}` (destination directory).

## Common Eclasses

- `cargo`: Rust projects.
- `cmake`: CMake-based projects.
- `distutils-r1`: Python packages using standard packaging.
- `go-module`: Go projects.
- `meson`: Meson-based projects.
- `python-single-r1`: Single Python implementation packages (rare).

## Version Suffixes

- `_alpha`: Alpha release
- `_beta`: Beta release
- `_rc`: Release candidate
- `_p`: Patch-level or snapshot date (e.g., `2.0_p20250401`).

## Build systems that are badly behaved

Some build systems may do unusual things like call CMake inside to build something or even fetch
something online. Unfortunately you have to reverse engineer said system to figure out how to make
it compliant with Gentoo standards.

If a project uses CMake to build something randomly inside, you should instead use `cmake.eclass` to
build that separately (and possibly make it a separate ebuild), and then figure out how to make the
build system use that copy of the output rather than wanting to build its own. This also applies
for any other build system such as Meson or autoconf.

If a project fetches something online during the build, you need to figure out the URI and add it
`SRC_URI`. Then you may need to patch the build system to accept the copy that Portage downloads
instead of trying to fetch its own. Often this means finding where the build system expects to
find the file and placing it there before starting the build.
