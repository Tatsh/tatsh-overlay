# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
KFMIN=6.3.0
QTMIN=6.6.2

inherit ecm

DESCRIPTION="Time tracking with WakaTime for Kate."
HOMEPAGE="https://github.com/tatsh/kate-wakatime"
SRC_URI="https://github.com/Tatsh/kate-wakatime/archive/v${PV}.tar.gz -> ${PN}-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="6"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="aqua debug"

DEPEND=">=kde-frameworks/ktexteditor-${KFMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kparts-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	dev-qt/qtbase:6"
RDEPEND="${DEPEND}"

src_install() {
	ecm_src_install
	mkdir -p "${ED}/usr/$(get_libdir)/qt6/plugins/kf6/ktexteditor" || die
	mv "${ED}/ktexteditor/ktexteditor_wakatime.so" \
		"${ED}/usr/$(get_libdir)/qt6/plugins/kf6/ktexteditor/" || die
}
