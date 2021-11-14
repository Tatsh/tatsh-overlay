# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SHA="480428199a1c92e0ad0d8b1a5f5ddbaaad5d7b64"
SRC_URI="https://github.com/cmdpack/cmdpack/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
KEYWORDS="~amd64 ~x86"
inherit eutils

DESCRIPTION="Neill Corlett's command-Line pack."
HOMEPAGE="http://www.neillcorlett.com/cmdpack/"

LICENSE="GPL-3"
SLOT="0"

DEPEND="!media-sound/vb2rip
	!app-cdr/bin2iso"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/01_cflags.patch")

src_compile() {
	cd src
	for i in bin2iso \
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
			./mkgcc "${i%.*}"
		done
}

src_install() {
	dodoc README.md
	cd src
	for i in bin2iso \
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
			dobin "$i"
		done

	dosym "${EPREFIX}/usr/bin/ecm" /usr/bin/unecm
}

# kate: replace-tabs false;
