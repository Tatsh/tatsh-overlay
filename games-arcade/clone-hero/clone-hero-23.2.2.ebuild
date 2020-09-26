# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Clone of Guitar Hero and similar games."
HOMEPAGE="https://clonehero.net/"
SRC_URI="http://dl.clonehero.net/clonehero-v.${PV}/clonehero-linux.tar.gz"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="sys-libs/zlib
	x11-libs/wxGTK"
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/clonehero-linux"

src_install() {
	find . -name '*.so*' -exec chmod 0755 {} \; || die
	find . -name '*.dll' -exec chmod 0644 {} \; || die
	einstalldocs
	rm README.txt || die
	mkdir -p "${D}/opt/clonehero" || die
	cp -R ./* "${D}/opt/clonehero/" || die
	mkdir "${D}/opt/bin" || die
	cat > ${D}/opt/bin/clonehero <<EOF
#!/usr/bin/env bash
cd /opt/clonehero
./clonehero "\$@"
EOF
	fperms 0755 /opt/bin/clonehero /opt/clonehero/clonehero
}
