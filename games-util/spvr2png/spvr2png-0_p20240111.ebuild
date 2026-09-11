# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Image converter from Sega Dreamcast PVR format to PNG."
HOMEPAGE="https://github.com/nextgeniuspro/spvr2png"
SHA="bc6c35945d072c78f9bc0e79f396d189082c5609"
SRC_URI="https://github.com/nextgeniuspro/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-libs/stb"

src_prepare() {
	default
	rm stb_image.h stb_image_write.h || die
}

src_compile() {
	emake CC="$(tc-getCXX)" \
		CFLAGS="${CXXFLAGS} -std=c++17 -I${ESYSROOT}/usr/include/stb" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
