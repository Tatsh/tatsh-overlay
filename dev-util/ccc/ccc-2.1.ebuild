# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Parser and dumper for debugging symbols from PlayStation 2 games."
HOMEPAGE="https://github.com/chaoticgd/ccc"
SRC_URI="https://github.com/chaoticgd/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

# MIT covers upstream's own code. thirdparty/demanglegnu is libiberty taken
# from GCC 13.2.0, whose files are a mix of GPL-2+ and LGPL-2.1+.
LICENSE="MIT GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/rapidjson
	test? ( dev-cpp/gtest )"

PATCHES=(
	"${FILESDIR}/${P}-system-libraries.patch"
	"${FILESDIR}/${P}-version.patch"
)

src_prepare() {
	cmake_src_prepare

	rm -r thirdparty/rapidjson thirdparty/googletest || die
}

src_install() {
	# Upstream defines no install rules; these are the four tools it puts in a
	# release. objdump and demangle are too generic to install under those
	# names, and objdump would collide with sys-devel/binutils outright.
	dobin "${BUILD_DIR}"/stdump "${BUILD_DIR}"/uncc
	newbin "${BUILD_DIR}"/objdump ccc-objdump
	newbin "${BUILD_DIR}"/demangle ccc-demangle

	dodoc README.md CHANGELOG.md
	dodoc -r docs
}
