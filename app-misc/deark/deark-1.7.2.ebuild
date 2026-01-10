# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility to extract data from various file formats."
HOMEPAGE="https://entropymine.com/deark/ https://github.com/jsummers/deark"
SRC_URI="https://github.com/jsummers/deark/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( readme.md formats.txt technical.md )

src_prepare() {
	sed -re 's/install -s/install/g' -i Makefile || die
	default
}

src_install() {
	mkdir -p "${D}/usr/bin" || die
	emake DEARK_INSTALLDIR="${D}/usr/bin" install
	einstalldocs
}
