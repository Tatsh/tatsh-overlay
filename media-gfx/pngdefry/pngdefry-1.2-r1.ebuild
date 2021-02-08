# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Convert iOS and macOS compressed PNG files to normal."
HOMEPAGE="http://www.jongware.com/pngdefry.html"
SRC_URI="http://www.jongware.com/binaries/pngdefry.zip -> ${P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

S="${WORKDIR}/source"

src_compile() {
	echo $(tc-getCC) -o "$PN" ${CFLAGS} ${LDFLAGS} "${PN}.c"
	$(tc-getCC) -o "$PN" ${CFLAGS} ${LDFLAGS} "${PN}.c" || die
}

src_install() {
	dobin pngdefry
	doman ../man/pngdefry.1
}
