# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2

DESCRIPTION="Yahoo! JavaScript and CSS compressor (minifier)."
HOMEPAGE="https://github.com/yui/yuicompressor"
EGIT_REPO_URI="git://github.com/yui/yuicompressor.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}
virtual/jdk
dev-java/ant-nodeps"

src_compile() {
	cd "${S}"
	ant
}

src_install() {
	cd "${S}"
	local jar=$(find . -iname 'yui*.jar' | head -n 1)
	
	insinto /usr/share/yui-compressor
	doins "$jar"

	local bin="$PN"
	jar=$(basename "$jar")
	echo "#!/bin/sh" > "$bin"
	echo "java -jar /usr/share/yui-compressor/$jar \$@" >> "$bin"
	exeinto /usr/bin
	doexe "$bin"
}

src_test() {
	cd "${S}"
	./tests/suite.sh
}
