# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Neill Corlett's command-line pack."
HOMEPAGE="http://www.neillcorlett.com/cmdpack/"
SHA="6674a1068d890279fad613ae37e7a170475f8970"
SRC_URI="https://github.com/cmdpack/cmdpack/archive/${SHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${SHA}/src"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="!media-sound/vb2rip
	!app-cdr/bin2iso"
RDEPEND="${DEPEND}"

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
	dodoc ../README.md
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
}
