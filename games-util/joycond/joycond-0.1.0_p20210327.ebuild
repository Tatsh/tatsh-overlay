# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Combine joy-cons using hid-nintendo"
HOMEPAGE="https://github.com/DanielOgorchock/joycond"
SHA="2d3f553060291f1bfee2e49fc2ca4a768b289df8"
SRC_URI="https://github.com/DanielOgorchock/joycond/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	dev-libs/libevdev
	virtual/udev"
RDEPEND="${DEPEND}
	games-util/hid-nintendo"
IUSE="systemd"

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	cmake_src_install
	if ! use systemd; then
		rm -rf "${D}"/etc/modules-load.d
		mkdir "${D}"/etc/init.d/
		echo -e "#!/sbin/openrc-run\ncommand=/usr/bin/${PN}" \
			> "${D}"/etc/init.d/${PN}
		chmod +x "${D}"/etc/init.d/${PN}
	fi
}
