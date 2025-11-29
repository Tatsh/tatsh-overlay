# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Convert iOS and macOS compressed PNG files to normal."
HOMEPAGE="https://web.archive.org/web/20211120053356/http://www.jongware.com/pngdefry.html"
SRC_URI="https://web.archive.org/web/20211205021959/http://www.jongware.com/binaries/${PN}.zip -> ${P}.zip"
S="${WORKDIR}/source"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

BDEPEND="app-arch/unzip"

src_compile() {
	read -ra cflags <<< "${CFLAGS-}"
	read -ra ldflags <<< "${LDFLAGS-}"
	echo "$(tc-getCC)" -o "$PN" "${cflags[@]}" "${ldflags[@]}" "${PN}.c"
	$(tc-getCC) -o "$PN" "${cflags[@]}" "${ldflags[@]}" "${PN}.c" || die
}

src_install() {
	dobin pngdefry
	doman ../man/pngdefry.1
}
