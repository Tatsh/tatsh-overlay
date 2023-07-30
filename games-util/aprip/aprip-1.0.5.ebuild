# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Remove additional copy protection found in some later PS1 games."
HOMEPAGE="https://alex-free.github.io/aprip/ https://github.com/alex-free/aprip"
SRC_URI="https://github.com/alex-free/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	sed -re 's/^CC=/CC?=/' -e 's/^CFLAGS=/CFLAGS?=/' -i Makefile || die
	default
}

src_compile() {
	emake "${PN}"
}

src_install() {
	dobin "${PN}" ap-type-checker.sh cd-command-logger.sh
	einstalldocs
}
