# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Neill Corlett's command-line pack."
HOMEPAGE="https://web.archive.org/web/20140330233023/https://neillcorlett.com/cmdpack/"
SRC_URI="https://web.archive.org/web/20130616041227/http://www.neillcorlett.com/downloads/${P}-src.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}-src/src"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="!media-sound/vb2rip
	!app-cdr/bin2iso"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-cdpatch-uppercase-flag.patch"
)

DOCS=( ../doc/cmdpack.txt )

src_compile() {
	local app
	local cc
	read -ra cflags <<< "${CFLAGS-}"
	cc=$(tc-getCC)
	for app in bin2iso \
		bincomp \
		brrrip \
		byteshuf \
		byteswap \
		cdpatch \
		ecm \
		fakecrc \
		hax65816 \
		id3point \
		rels \
		screamf \
		subfile \
		uips \
		vb2rip \
		wordadd \
		zerofill; do
		echo "${cc}" "${cflags[@]}" -fomit-frame-pointer -o ${app} ${app}.c
		"${cc}" "${cflags[@]}" -fomit-frame-pointer -o ${app} ${app}.c || die
	done
}

src_install() {
	dobin bincomp \
		brrrip \
		byteshuf \
		byteswap \
		cdpatch \
		ecm \
		fakecrc \
		hax65816 \
		id3point \
		rels \
		screamf \
		subfile \
		uips \
		vb2rip \
		wordadd \
		zerofill
	dosym -r "${EPREFIX}/usr/bin/ecm" /usr/bin/unecm
	einstalldocs
}
