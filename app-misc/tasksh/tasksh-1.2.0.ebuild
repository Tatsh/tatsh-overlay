# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Shell command that wraps Taskwarrior commands"
HOMEPAGE="https://gothenburgbitfactory.org/projects/tasksh.html"
LIBSHARED_SHA="f1a3cd6bfabfb083fe3c26f580a15c0d60a92ee9"
SRC_URI="https://github.com/GothenburgBitFactory/taskshell/archive/v1.2.0.tar.gz -> ${P}.tar.gz
	https://github.com/GothenburgBitFactory/libshared/archive/${LIBSHARED_SHA}.tar.gz -> ${PN}-libshared-${LIBSHARED_SHA:0:7}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/readline"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}ell-${PV}"

src_prepare() {
	sed -e "s|TASKSH_DOCDIR\\s\\+share/doc/tasksh|TASKSH_DOCDIR share/doc/${P}|" \
		-i CMakeLists.txt || die
	rmdir src/libshared || die
	mv "../libshared-${LIBSHARED_SHA}" src/libshared || die
	touch src/commit.h
	cmake_src_prepare
}
