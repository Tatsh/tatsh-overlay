# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="cplugins(+),libmpv"

USE_MPV="rdepend"

inherit mpv-plugin toolchain-funcs

DESCRIPTION="Shows progress on a panel following libunity specification."
HOMEPAGE="https://github.com/mrlotfi/mpv-libunity"
SHA="e111b49e7d4ace2c6b19baf5ff0a70353aa28776"
SRC_URI="https://github.com/mrlotfi/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

DEPEND="dev-qt/qtbase:6[dbus]"
RDEPEND+="${DEPEND}"

MY_PN="${PN#*-}"

MPV_PLUGIN_FILES=( "${MY_PN}.so" )

src_prepare() {
	default
	mv libunity.c libunity.cpp || die
	sed -re 's/Qt5/Qt6/g' -e 's/std=c\+\+11/std=c\+\+17/g' -e 's/-O3//' \
		-e 's/CC =/CC ?=/' -e 's/PKG_CONFIG =/PKG_CONFIG ?=/' \
		-e 's/libunity\.c/libunity.cpp/' \
		-i Makefile || die
}

src_compile() {
	emake "CC=$(tc-getCXX)" "PKG_CONFIG=$(tc-getPKG_CONFIG)"
}
