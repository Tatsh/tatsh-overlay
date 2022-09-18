# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
WX_GTK_VER="3.0-gtk3"
inherit udev wxwidgets

DESCRIPTION="Graphical user interface and command-line tools to manage raphnet adapters."
HOMEPAGE="https://www.raphnet-tech.com/products/adapter_manager/index.php"
SRC_URI="https://www.raphnet-tech.com/downloads/raphnet-tech_adapter_manager-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE="firmware"

DEPEND="dev-libs/atk
	dev-libs/glib
	dev-libs/hidapi
	media-libs/harfbuzz
	sys-libs/zlib
	virtual/udev
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/pango
	x11-libs/wxGTK:3.0-gtk3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/raphnet-tech_adapter_manager-${PV}"

src_prepare() {
	sed -e 's/, TAG+=".*/, GROUP="plugdev", MODE="0660"/g' \
		-i scripts/*.rules || die "Failed to patch"
	default
}

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
	if use firmware; then
		insinto /usr/share/${PN}
		doins -r firmwares
	fi
}
