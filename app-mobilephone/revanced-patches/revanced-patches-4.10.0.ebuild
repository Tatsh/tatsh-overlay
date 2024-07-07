# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-utils-2

DESCRIPTION="Patches for ReVanced."
HOMEPAGE="https://github.com/ReVanced/revanced-patches https://revanced.app/"
SRC_URI="https://github.com/ReVanced/revanced-patches/releases/download/v${PV}/${P}.jar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-11-r2"

S="${WORKDIR}"

src_install() {
	java-pkg_newjar "${DISTDIR}/${P}.jar"
}
