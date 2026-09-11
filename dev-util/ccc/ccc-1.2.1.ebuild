# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Parser and dumper for debugging symbols from PlayStation 2 games."
HOMEPAGE="https://github.com/chaoticgd/ccc"
SRC_URI="https://github.com/chaoticgd/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

# MIT covers upstream's own code. demanglegnu is libiberty taken from GCC,
# whose files are a mix of GPL-2+ and LGPL-2.1+.
LICENSE="MIT GPL-2+ LGPL-2.1+"
# Kept alongside the current release for dev-util/ghidra-emotionengine-reloaded,
# which reads stdump's JSON and rejects anything but format version 7. ccc 2.0
# rewrote that output into a symbol database, bringing it to version 14, and
# renamed the print_json command to json.
SLOT="1.2"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

src_prepare() {
	cmake_src_prepare

	# alloca.c only includes stdlib.h when told the header exists, so without
	# this free() and abort() are implicitly declared, which GCC 14 rejects.
	# Upstream defines it in the 2.x copy of the same demangler.
	sed -i 's/-DHAVE_STRING_H=1)$/-DHAVE_STRING_H=1 -DHAVE_STDLIB_H=1)/' \
		demanglegnu/CMakeLists.txt || die
	grep -q HAVE_STDLIB_H demanglegnu/CMakeLists.txt ||
		die "failed to define HAVE_STDLIB_H"

	# Upstream stamps the version from the git tag, which a release tarball has
	# no way to report.
	sed -i 's/^\tset(GIT_TAG "")$/\tset(GIT_TAG "v'"${PV}"'")/' \
		cmake/version_finder.cmake || die
	grep -q "v${PV}" cmake/version_finder.cmake || die "failed to set the version"
}

src_install() {
	# Upstream defines no install rules. Only stdump is installed, under a name
	# of its own: this slot exists for the one consumer of its output format,
	# and the current slot provides the rest.
	newbin "${BUILD_DIR}"/stdump stdump-${SLOT}

	dodoc README.md CHANGELOG.md
}
