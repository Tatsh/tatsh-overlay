# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hook application for (patched) openfortivpn to support systemd-resolved."
HOMEPAGE="https://github.com/Tatsh/ifup-systemd-resolved"
SRC_URI="https://github.com/Tatsh/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtbase:6[dbus,network]"
RDEPEND="${DEPEND}"

src_install() {
	cmake_src_install
	doman "man/${PN}.1"
}
