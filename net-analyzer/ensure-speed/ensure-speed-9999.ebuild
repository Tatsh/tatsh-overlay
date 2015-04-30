# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python3_{3,4} )

inherit distutils-r1 systemd

DESCRIPTION="Add-on for speedtest-cli to ensure certain WAN speed thresholds"
HOMEPAGE="https://github.com/Tatsh/misc-scripts"
SRC_URI="https://raw.githubusercontent.com/Tatsh/misc-scripts/master/ensure-speed -> ${P}.py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pyyaml-3.11
>=net-analyzer/speedtest-cli-0.2.4
>=dev-python/sh-1.09"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	einfo 'Nothing to unpack'
}

src_compile() {
	einfo 'Nothing to compile'
}

src_install() {
	cp -L "${DISTDIR}/${A}" "${PN}"
	exeinto /usr/bin
	doexe "${PN}"

	# It is strange that ebuild manifest does not work with files that have an @ sign
	for i in timer service; do
		systemd_newunit "${FILESDIR}/ensure-speed.${i}" "ensure-speed@.${i}"
	done

	if systemd_is_booted; then
		einfo
		einfo 'A service and a timer service have been installed for use with'
		einfo 'systemd. Please copy or symlink these to your unit directory'
		einfo '(either /etc/systemd/system or your user unit directory)'
		einfo
	fi
}
