# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit udev wxwidgets

DESCRIPTION="Graphical user interface and command-line tools to manage raphnet adapters."
HOMEPAGE="https://www.raphnet-tech.com/products/adapter_manager/index.php"
SRC_URI="https://www.raphnet-tech.com/downloads/raphnet-tech_adapter_manager-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/hidapi
	x11-libs/wxGTK:3.0-gtk3
	sys-libs/zlib
	virtual/udev"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/raphnet-tech_adapter_manager-${PV}"

src_compile() {
	cd src
	emake PLATFORM_CFLAGS="${CFLAGS}"
}

src_install() {
	pushd src || die
	mkdir -p "${D}/usr/bin" || die
	emake install PREFIX="${D}/usr" || die
	popd || die
	udev_dorules scripts/*.rules
	einstalldocs
}
