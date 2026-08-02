# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="Software for the 40Mhz USB-3.0 RF sampler (harrypm fork)."
HOMEPAGE="https://github.com/simoninns/DomesdayDuplicator"
# Upstream moved the application out of the umbrella repository into the
# gui-app submodule; the parent now only carries docs, firmware and hardware
# designs, none of which this package installs.
MY_PN="DomesdayDuplicator"
SHA="8036eaf1acce3c675b38c07c275d7a03c718d3a4"
SRC_URI="https://github.com/simoninns/${MY_PN}-gui-app/archive/${SHA}.tar.gz
	-> ${P}-${SHA:0:8}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-gui-app-${SHA}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/qcustomplot
	dev-qt/qtbase:6
	dev-qt/qtserialport:6
	virtual/libusb:1"
RDEPEND="${DEPEND}"

src_prepare() {
	# Build against the system QCustomPlot instead of the vendored copy.
	rm "tools/${MY_PN}/qcustomplot.cpp" "tools/${MY_PN}/qcustomplot.h" || die
	sed -e '/^    qcustomplot\.cpp$/d' \
		-e '/^# Suppress deprecation warnings for third-party QCustomPlot/,+3d' \
		-e 's/^    Qt::SerialPort$/    Qt::SerialPort\n    qcustomplot/' \
		-i "tools/${MY_PN}/CMakeLists.txt" || die
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	einstalldocs
	local size
	for size in 16 24 32 48 64 128 256; do
		newicon -s "${size}" \
			"tools/${MY_PN}/Graphics/ApplicationIcon/${MY_PN}_${size}x${size}.png" \
			"${PN}.png"
	done
	make_desktop_entry "${MY_PN}" "${PN}"
}
