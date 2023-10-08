# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-mod-r1

DESCRIPTION="Kernel module for the embedded controller of MSI laptops."
HOMEPAGE="https://github.com/BeardOverflow/msi-ec"
SHA="c39fe616c24e2ff12f086dfbc34358499c13f6bf"
SRC_URI="https://github.com/BeardOverflow/msi-ec/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${SHA}"

src_compile() {
	local modlist=( "${PN}" )
	local modargs=( clean modules )
	linux-mod-r1_src_compile
}
