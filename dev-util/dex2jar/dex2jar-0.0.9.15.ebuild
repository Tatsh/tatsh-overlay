# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mercurial

DESCRIPTION="Tools to work with android .dex and java .class files"
HOMEPAGE="https://code.google.com/p/dex2jar/"
EHG_REPO_URI="https://code.google.com/p/dex2jar/"
EHG_REVISION="0.0.9.15"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-java/maven-bin
virtual/jdk"
RDEPEND="${DEPEND}"

src_compile () {
	cp "${FILESDIR}/settings.xml" .
	sed -i settings.xml -e "s/\$VERSION/$PV/g"
	mkdir repo
	hg checkout 0.0.9.15
	mvn -ff -DskipTests=true -Dmaven.test.skip=true -s settings.xml package || die "Failed to build"

	local zip="${WORKDIR}/${PN}-$PV/dex-tools/target/${PN}-$PV.zip"
	[ -f "$zip" ] || die "Failed to build"

	unzip "$zip"
	pushd ${PN}-$PV
	mv *.sh lib *.txt ..
	popd
}

src_install () {
	local wrapper="${FILESDIR}/_d2j-wrapper.py"
	dodoc LICENSE.txt NOTICE.txt lib/*.txt lib/dx-NOTICE

	exeinto /usr/bin
	doexe "$wrapper"
	wrapper=/usr/bin/_d2j-wrapper.py

	insinto /usr/share/dex2jar
	doins lib/*.jar

	for i in d2j-apk-sign \
		d2j-asm-verify \
		d2j-decrpyt-string \
		d2j-dex-asmifier \
		d2j-dex-dump \
		d2j-dex2jar \
		d2j-init-deobf \
		d2j-jar-access \
		d2j-jar-remap \
		d2j-jar2dex \
		d2j-jar2jasmin \
		d2j-jasmin2jar \
		dex-dump \
		dex2jar; do
		dosym "$wrapper" "/usr/bin/$i"
	done
}
