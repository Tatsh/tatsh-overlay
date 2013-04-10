# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils git-2 bash-completion-r1

# TODO Patch out distributed Rhino (unless not possible) and use dev-java/rhino

EGIT_REPO_URI="https://code.google.com/p/closure-compiler/"
DESCRIPTION="JavaScript optimising compiler."
HOMEPAGE="http://code.google.com/p/closure-compiler/"
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion externs"

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}
	virtual/jdk
	dev-java/ant-nodeps"

src_compile() {
	cd "${S}"
	ant

	if use bash-completion; then
		cp "${FILESDIR}/ListCharsets.java" .
		javac ListCharsets.java || die "Failed to compile ListCharsets.java"
		java ListCharsets | sort > charsets.txt
	fi
}

src_install() {
	local sharedir="share/closure-compiler"
	mkdir -p ${sharedir}
	cp ${S}/build/compiler.jar "${sharedir}"

	if use externs; then
		cp -R ${S}/externs ${S}/contrib/externs "${sharedir}"
	fi
	insinto /usr
	doins -r share

	local bin="closure-compiler"
	local jar="/usr/share/closure-compiler/compiler.jar"
	echo "#!/bin/sh" > "${bin}"
	echo "java -classpath $jar -jar $jar \$@" >> "${bin}"
	dobin closure-compiler

	if use bash-completion; then
		newbashcomp "${FILESDIR}/closure-compiler" closure-compiler
		insinto /usr/share/closure-compiler
		doins "${S}/charsets.txt"
	fi
}

pkg_postinst() {
	if use externs; then
		elog
		elog "Externs have been installed in /usr/share/closure-compiler/externs"
		elog
	fi
}
