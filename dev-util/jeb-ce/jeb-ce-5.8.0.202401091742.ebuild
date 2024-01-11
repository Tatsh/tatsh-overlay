# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Reverse-engineering platform to perform disassembly and analysis of code."
HOMEPAGE="https://www.pnfsoftware.com/jeb/"
SRC_URI="https://jebbuilds2.s3.amazonaws.com/jeb4ce/${P}-JEBDecompiler-624458483834837192.zip -> ${P}.zip"

LICENSE="JEB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/jdk:17"

S="${WORKDIR}"

src_prepare() {
	rm bin/app/jeb-license.txt
	default
}

src_install() {
	local i
	insinto "/opt/jeb-ce/${i}"
	for i in bin coreplugins doc scripts siglibs typelibs; do
		doins -r "${i}"
	done
	doins filelist.txt create_plugin_project.py
	newbin jeb_linux.sh jeb
}
