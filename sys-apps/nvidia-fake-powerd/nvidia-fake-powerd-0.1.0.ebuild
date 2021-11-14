# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd

DESCRIPTION="dbus blackhole for nvidia.powerd.server for working around a bug in nvidia-495 drivers."
HOMEPAGE="https://forums.developer.nvidia.com/t/bug-nvidia-v495-29-05-driver-spamming-dbus-enabled-applications-with-invalid-messages/192892/9"
SRC_URI="https://aur.archlinux.org/cgit/aur.git/snapshot/nvidia-fake-powerd.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}"

src_prepare() {
	default
	sed -r -e 's/user="dbus"/user="messagebus"/g' -i "${PN}.conf" || die
	sed -r -e 's/(User|Group)=dbus/\1=messagebus/g' -i "${PN}.service" || die
}

src_install() {
	insinto /usr/share/dbus-1/system.d
	doins "${PN}.conf"
	systemd_dounit "${PN}.service"
}

pkg_postint() {
	einfo
	einfo "Enable and start nvidia-fake-powerd.service to stop the dbus log spam caused by the NVIDIA driver:"
	einfo
	einfo "systemctl enable --now nvidia-fake-powerd"
	einfo
}
