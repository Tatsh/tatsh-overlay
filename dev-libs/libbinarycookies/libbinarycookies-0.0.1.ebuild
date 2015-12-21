# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit multilib

DESCRIPTION="Library to parse Apple's binarycookies format. "
HOMEPAGE="https://github.com/Tatsh/libbinarycookies"
SRC_URI="https://github.com/Tatsh/libbinarycookies/archive/v0.0.1.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples +tools"
DOCS="README.md"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS} -std=c11 -pedantic -Wall"
	use tools && emake examples
}

src_install() {
	dodir /usr/include /usr/$(get_libdir)/
	sed -r -e "8s/(.*)/LIBDIR := lib/" -e '18s#/lib$#/$(LIBDIR)#' -i Makefile
	local -r modname=$(get_modname)
	emake install DESTDIR="${D}/usr" LIBDIR="$(get_libdir)" LIBEXTENSION="${modname:1}"
	# emake install ignoring symlinks
	rm -f ${D}/usr/$(get_libdir)/${PN}${modname} ${D}/usr/$(get_libdir)/${PN}${modname}.0
	pushd ${D}/usr/$(get_libdir)/
		ls -la
		dosym ${PN}${modname}.${PV} /usr/$(get_libdir)/${PN}${modname}.${PV:0:1}
		dosym ${PN}${modname}.${PV:0:1} /usr/$(get_libdir)/${PN}.${modname}
	popd

	if use tools; then
		exeinto /usr/bin
		mv convert2netscape bincookie2netscape
		doexe bincookie2netscape
	fi

	if use examples; then
		local -r example_dir="/usr/share/${PN}"
		dodir "$example_dir"
		insinto "$example_dir"
		doins -r examples
	fi
}
