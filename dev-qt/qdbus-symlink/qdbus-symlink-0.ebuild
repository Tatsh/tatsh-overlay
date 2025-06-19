# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Symbolic link qdbus -> qdbus6."
HOMEPAGE="https://www.qt.io/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtbase:6
	dev-qt/qttools:6"

S="${WORKDIR}"

src_install() {
	dosym -r /usr/bin/qdbus6 /usr/bin/qdbus
}
