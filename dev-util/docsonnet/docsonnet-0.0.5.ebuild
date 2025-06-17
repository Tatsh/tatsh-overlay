# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Experimental Jsonnet docs generator (library only)."
HOMEPAGE="https://github.com/jsonnet-libs/docsonnet"
SRC_URI="https://github.com/jsonnet-libs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( doc-util/README.md )

src_compile() {
	:
}

src_install() {
	insinto /usr/share/jsonnet
	doins -r doc-util
	rm -f "${D}/usr/share/jsonnet/doc-util/README.md"
	einstalldocs
}

pkg_postinst() {
	einfo
	einfo "To use the library, add this line to the file you wish to document:"
	einfo
	echo "d = import 'doc-util/main.libsonnet';"
	einfo
	einfo "Then call jsonnet with \`-J ${EPREFIX}/usr/share/jsonnet\`."
}
