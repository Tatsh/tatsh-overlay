# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils

DESCRIPTION="Software for the 40Mhz USB-3.0 RF sampler (harrypm fork)."
HOMEPAGE="https://github.com/harrypm/DomesdayDuplicator"
SHA="82be17444426836d2bd7ff22c0d12266b661a8f2"
MY_PN="DomesdayDuplicator"
SRC_URI="https://github.com/harrypm/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtserialport:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	virtual/libusb:1"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_PN}-${SHA}/Linux-Application"

PROJECTS=( dddconv dddutil "${MY_PN}" )

src_configure() {
	local proj
	for proj in "${PROJECTS[@]}"; do
		pushd "$proj" || die
		eqmake5
		popd || die
	done
}

src_compile() {
	local proj
	for proj in "${PROJECTS[@]}"; do
		pushd "$proj" || die
		emake
		popd || die
	done
}

src_install() {
	local proj size icon
	for proj in "${PROJECTS[@]}"; do
		dobin "${proj}/${proj}"
	done
	for icon in "${MY_PN}/Graphics/ApplicationIcon/"*.png; do
		[[ "$icon" = *300x300.png ]] && continue
		size="${icon#*_}"
		size="${size#*x}"
		size="${size%.*}"
		newicon -s "$size" "$icon" "${MY_PN}.png"
	done
	make_desktop_entry "${MY_PN}" "Domesday Duplicator" "${MY_PN}"
	einstalldocs
}
