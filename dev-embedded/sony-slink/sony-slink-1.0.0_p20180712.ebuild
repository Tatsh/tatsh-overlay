# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Sony_SLink"

# Upstream has never tagged a release; library.properties declares 1.0.0.
MY_COMMIT="df17fdd32b6d4c089c88de214e7a27bd3b66effb"

DESCRIPTION="Arduino library for the Sony S-Link/Control-A1 bus protocol."
HOMEPAGE="https://github.com/Ircama/Sony_SLink"
SRC_URI="https://github.com/Ircama/${MY_PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

# This is Arduino source, compiled by the IDE against an AVR toolchain rather
# than built here.
PDEPEND="dev-embedded/arduino"

src_install() {
	insinto "/usr/share/arduino/hardware/arduino/avr/libraries/${MY_PN}"
	doins -r examples keywords.txt library.json library.properties \
		"${MY_PN}".cpp "${MY_PN}".h

	einstalldocs
}
