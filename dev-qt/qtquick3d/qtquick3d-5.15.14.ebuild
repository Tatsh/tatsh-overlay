# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qt5-build

DESCRIPTION="Qt module and API for defining 3D content in Qt QuickTools"
_QT5_PV="5.15.14"
SLOT="5/${_QT5_PV}"

KEYWORDS="~amd64"
DEPEND="dev-qt/qtcore:5=
	dev-qt/qtdeclarative:5=
	dev-qt/qtgui:5=
	media-libs/assimp:=
	sys-libs/zlib"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-assimp.patch" )

src_prepare() {
	rm -r src/3rdparty/assimp/src/{code,contrib,include} || die
	qt5-build_src_prepare
}

src_configure() {
	local myqmakeargs=(
		--
		-system-quick3d-assimp
	)
	qt5-build_src_configure
}
