# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Update IPv6 CIDR in config files and restart relevant systemd units."
HOMEPAGE="https://github.com/Tatsh/ipv6-config-update"
SRC_URI="https://github.com/Tatsh/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtbase:6[dbus,network]
	sys-apps/systemd"
RDEPEND="${DEPEND}"
