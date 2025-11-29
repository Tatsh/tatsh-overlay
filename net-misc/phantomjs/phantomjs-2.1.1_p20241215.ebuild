# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Scriptable headless browser (forked and supports Qt 6)."
HOMEPAGE="https://github.com/Tatsh/phantomjs"
SHA="b72a23fa390163ee7b54564ea3bd08c493c4ca8b"
SRC_URI="https://github.com/Tatsh/phantomjs/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtwebkit:6
	dev-qt/qtbase:6
	dev-qt/qt5compat:6"
RDEPEND="${DEPEND}"
