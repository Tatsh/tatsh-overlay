# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="Enhanced (unofficial) qpxtool version."
HOMEPAGE="https://github.com/speed47/qpxtool"
MY_PV="$(ver_cut 1-3)"
MY_PL="$(ver_cut 4)"
SRC_URI="https://github.com/speed47/${PN}/archive/refs/tags/v${MY_PV}-pl${MY_PL}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}-pl${MY_PL}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +gui +internal-wt +liteon-probe"

DEPEND="gui? ( dev-qt/qtbase:6[gui,network,sql,widgets] )
	media-libs/libpng"
RDEPEND="${DEPEND}"

src_prepare() {
	# Disable stripping.
	sed -re 's/.*strip .*/echo/g' -i configure || die
	sed -re 's/^all:.*//' -e 's/\.gz//g' -e 's/^install:.*/install:/g' -i man/Makefile || die
	default
}

src_configure() {
	# Not autotools.
	local args=( --prefix=/usr )
	if use gui; then
		args+=( "--qmake=${EPREFIX}/usr/bin/qmake6" )
	fi
	if use debug; then
		args+=( --enable-debug )
	fi
	if ! use gui; then
		args+=( --disable-gui )
	fi
	if ! use internal-wt; then
		args+=( --disable-internal-wt )
	fi
	if ! use liteon-probe; then
		args+=( --disable-liteon-probe )
	fi
	edo ./configure "${args[*]}"
}
