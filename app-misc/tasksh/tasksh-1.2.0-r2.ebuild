# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )

inherit cmake python-any-r1

DESCRIPTION="Shell command that wraps Taskwarrior commands"
HOMEPAGE="https://gothenburgbitfactory.org/tasksh/"
LIBSHARED_SHA="f1a3cd6bfabfb083fe3c26f580a15c0d60a92ee9"
SRC_URI="https://github.com/GothenburgBitFactory/taskshell/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/GothenburgBitFactory/libshared/archive/${LIBSHARED_SHA}.tar.gz -> ${PN}-libshared-${LIBSHARED_SHA:0:7}.tar.gz"

S="${WORKDIR}/${PN}ell-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="sys-libs/readline:="
RDEPEND="${DEPEND}"
BDEPEND="test? ( ${PYTHON_DEPS} )"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	sed -e "s|TASKSH_DOCDIR\\s\\+share/doc/tasksh|TASKSH_DOCDIR share/doc/${P}|" \
		-i CMakeLists.txt || die
	rmdir src/libshared || die
	mv "../libshared-${LIBSHARED_SHA}" src/libshared || die
	touch src/commit.h
	# CMake 4 removed support for CMP0037 OLD. The tests do not define a
	# reserved target name, so the policy request is simply unnecessary.
	sed -i -e '/cmake_policy(SET CMP0037 OLD)/d' test/CMakeLists.txt || die
	cmake_src_prepare
}

src_test() {
	# The suite is run_all (TAP), behind a custom target that shadows CTest's. Only
	# run_all is copied to the build tree; the harness finds tasksh at ../src.
	cp -r "${S}"/test/{basetest,simpletap,*.t} "${BUILD_DIR}/test/" || die
	# The harness predates Python 3.9, and run_all counts a test it cannot start
	# as nothing run, not as a failure.
	sed -i -e "1s|python2\\.7|${EPYTHON}|" -e 's/assertRegexpMatches/assertRegex/' \
		"${BUILD_DIR}"/test/*.t || die
	sed -i 's/\.isAlive()/.is_alive()/' "${BUILD_DIR}"/test/basetest/utils.py || die
	cmake_build test
}
