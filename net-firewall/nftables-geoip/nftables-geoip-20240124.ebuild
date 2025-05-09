# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit python-r1

DESCRIPTION="Generates nftables maps of geolocation IP address blocks."
HOMEPAGE="https://github.com/pvxe/nftables-geoip"
SHA="252b1ac57059b35e4d286e0a0d06a5da77bcd743"
SRC_URI="https://github.com/pvxe/nftables-geoip/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	sed -re "s|^DEFAULT_FILE_LOCATION =.*|DEFAULT_FILE_LOCATION = '/usr/share/${PN}/location.csv'|" \
		-i nft_geoip.py
	default
}

src_install() {
	python_foreach_impl python_newscript nft_geoip.py nft-geoip
	insinto "/usr/share/${PN}"
	doins location.csv
	einstalldocs
}
