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

src_prepare() {
	cmake_src_prepare

	# Both are vendored as whole copies and both are packaged. The sources
	# include them as <rapidjson/...> and <gtest/gtest.h>, so the system copies
	# are found without any include path of their own.
	sed -i -e '/add_subdirectory(thirdparty\/rapidjson EXCLUDE_FROM_ALL)/d' \
		-e '/^target_link_libraries(ccc rapidjson)$/d' \
		-e 's|^add_subdirectory(thirdparty/googletest EXCLUDE_FROM_ALL)$|find_package(GTest REQUIRED)|' \
		-e 's/\bgtest)$/GTest::gtest)/' CMakeLists.txt || die
	rm -r thirdparty/rapidjson thirdparty/googletest || die

	# Upstream stamps the version from the git tag, which a release tarball has
	# no way to report, leaving the tools calling themselves a development
	# version.
	sed -i 's/^\tset(GIT_TAG "")$/\tset(GIT_TAG "v'"${PV}"'")/' \
		cmake/version_finder.cmake || die
	grep -q "v${PV}" cmake/version_finder.cmake || die "failed to set the version"
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
