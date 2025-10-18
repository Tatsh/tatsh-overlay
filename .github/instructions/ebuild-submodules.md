<!-- markdownlint-disable no-hard-tabs -->

# Creating Ebuilds for Projects with Submodules

## Overview

For projects with Git submodules that cannot use system libraries, manually fetch and position
submodule sources at specific commits.

## Version Format

Use `_p` suffix for snapshot dates: `2.0_p20250401` = version 2.0 as of 2025-04-01.

## Ebuild Structure

### 1. Define submodule SHAs

```bash
LIBFOO_SHA="abc123def456..."
LIBBAR_SHA="789ghi012jkl..."
```

### 2. Add to `SRC_URI`

```bash
SRC_URI="https://github.com/upstream/project/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/upstream/libfoo/archive/${LIBFOO_SHA}.tar.gz -> libfoo-${LIBFOO_SHA}.tar.gz
	https://github.com/upstream/libbar/archive/${LIBBAR_SHA}.tar.gz -> libbar-${LIBBAR_SHA}.tar.gz
"
```

**Note:** For forked libraries, prefix the output filename with the project name to avoid conflicts:

```bash
https://github.com/upstream/libfoo-fork/archive/${LIBFOO_SHA}.tar.gz -> ${PN}-libfoo-${LIBFOO_SHA}.tar.gz
```

### 3. Move sources in src_prepare

```bash
src_prepare() {
	rmdir "${S}/external/libfoo" || die
	mv "${WORKDIR}/libfoo-${LIBFOO_SHA}" "${S}/external/libfoo" || die

	rmdir "${S}/external/libbar" || die
	mv "${WORKDIR}/libbar-${LIBBAR_SHA}" "${S}/external/libbar" || die

	default
}
```

## Finding Submodule SHAs

```bash
# Clone the repository at the desired tag/commit
git clone --recurse-submodules https://github.com/upstream/project
cd project
git checkout v2.0  # or specific commit

# List submodule commits
git submodule status
```

## Complete Example

```bash
EAPI=8

LIBFOO_SHA="abc123"
LIBBAR_SHA="def456"

SRC_URI="https://github.com/example/project/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/example/libfoo/archive/${LIBFOO_SHA}.tar.gz -> ${PN}-libfoo-${LIBFOO_SHA}.tar.gz
	https://github.com/example/libbar/archive/${LIBBAR_SHA}.tar.gz -> ${PN}-libbar-${LIBBAR_SHA}.tar.gz"

src_prepare() {
	rmdir "${S}/deps/libfoo" || die
	mv "${WORKDIR}/libfoo-${LIBFOO_SHA}" "${S}/deps/libfoo" || die

	rmdir "${S}/deps/libbar" || die
	mv "${WORKDIR}/libbar-${LIBBAR_SHA}" "${S}/deps/libbar" || die

	default
}
```

## Handling Forked Libraries

When submodules are forks, use `${PN}` prefix to avoid tarball name conflicts:

```bash
SRC_URI="https://github.com/example/project/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/example/imgui-fork/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA}.tar.gz"

src_prepare() {
	rmdir "${S}/external/imgui" || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" "${S}/external/imgui" || die
	default
}
```
