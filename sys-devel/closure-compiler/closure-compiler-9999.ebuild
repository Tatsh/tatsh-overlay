# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

# TODO Patch out distributed Rhino (unless not possible) and use dev-java/rhino
# TODO Install externs with USE flag?

EAPI=3
ESVN_REPO_URI="http://closure-compiler.googlecode.com/svn/trunk/"
DESCRIPTION="JavaScript optimising compiler."
HOMEPAGE="http://code.google.com/p/closure-compiler/"
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
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
	local sharedir="${D}usr/share/closure-compiler"
	cd "${S}/build"
	mkdir -p "${sharedir}"
	cp -v compiler.jar "${sharedir}"

	mkdir -p "${D}usr/bin"
	local bin="${D}usr/bin/closure-compiler"
	echo "#!/bin/sh" >> "${bin}"
	echo "java -jar /usr/share/closure-compiler/compiler.jar \$@" >> "${bin}"
	fperms a+x "/usr/bin/closure-compiler"
}
