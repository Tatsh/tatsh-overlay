# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git-2

EAPI=3
EGIT_REPO_URI="git://catacombae.git.sourceforge.net/gitroot/catacombae/catacombae"
DESCRIPTION="Mac OS X DMG file extractor."
HOMEPAGE="http://www.catacombae.org/dmgx.html"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}
	virtual/jdk"

src_compile() {
	cd "${S}/DMGExtractor"
	sh ./buildall.sh
}

src_install() {
	local sharedir="${D}usr/share/dmgextractor"
	cd "${S}/DMGExtractor"
	mkdir -p "${sharedir}"
	cp -v targets/application/lib/*.jar "${sharedir}"

	mkdir -p "${D}usr/bin"
	local bin="${D}usr/bin/dmgextractor"
	echo "#!/bin/sh" >> "${bin}"
	echo "cd /usr/share/dmgextractor" >> "${bin}"
	echo "java -jar dmgextractor.jar \$@" >> "${bin}"
	fperms a+x "/usr/bin/dmgextractor"
}
