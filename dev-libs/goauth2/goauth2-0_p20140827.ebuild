# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Go OAuth 2.0"
HOMEPAGE="https://code.google.com/p/goauth2/"
EHG_COMMIT="afe77d958c701557ec5dc56f6936fcc194d15520"
SRC_URI="https://goauth2.googlecode.com/archive/${EHG_COMMIT}.tar.gz -> ${P}.tar.gz"
GO_PN=code.google.com/p/${PN}
RESTRICT="strip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/go-1.4.2"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	default_src_unpack
	mkdir -p src/${GO_PN%/*} || die
	mv ${PN}-${EHG_COMMIT:0:12} src/${GO_PN} || die
}

src_compile() {
	# Create a filtered GOROOT tree out of symlinks,
	# excluding this package, for bug #503324.
	cp -sR /usr/lib/go goroot || die
	rm -rf goroot/src/${GO_PN} || die
	rm -rf goroot/pkg/linux_${ARCH}/${GO_PN} || die
	GOROOT=${WORKDIR}/goroot GOPATH=${WORKDIR} \
		go install -x ${GO_PN}/oauth || die
}

src_install() {
	insinto /usr/lib/go
	doins -r pkg
	insinto /usr/lib/go/src
	find src/${GO_PN} '(' -name .hgignore -o -name .hg -o -name .hgtags ')' -delete
	dodoc src/${GO_PN}/{AUTHORS,CONTRIBUTORS,LICENSE,PATENTS,README}
	rm src/${GO_PN}/{AUTHORS,CONTRIBUTORS,LICENSE,PATENTS,README}
	rm -fR src/${GO_PN}/{appengine,compute,lib} src/${GO_PN}/oauth/example src/${GO_PN}/oauth/jwt/example
	doins -r src/*
}
