# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git-2 eutils

DESCRIPTION="Neill Corlett's command-Line pack."
HOMEPAGE="http://www.neillcorlett.com/cmdpack/"
EGIT_REPO_URI="git://github.com/Tatsh/cmdpack.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="!media-sound/vb2rip
	!app-cdr/bin2iso"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/01_cflags.patch" || die "Patching failed!"
}

src_compile() {
	cd "${S}/src"

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
	cd "${S}/src"

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

		dosym /usr/bin/ecm /usr/bin/unecm
}

# kate: replace-tabs false;
