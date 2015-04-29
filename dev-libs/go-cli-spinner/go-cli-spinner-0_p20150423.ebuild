# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Simple spinner for the command line while your CLI application is working"
HOMEPAGE="https://github.com/odeke-em/cli-spinner"
EGIT_COMMIT="610063bb4aeef25f7645b3e6080456655ec0fb33"
GO_PN=github.com/odeke-em/${PN/go-/}
SRC_URI="https://${GO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
RESTRICT="strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	default_src_unpack
	mkdir -p src/${GO_PN%/*} || die
	mv ${PN/go-/}-${EGIT_COMMIT} src/${GO_PN} || die
}

src_compile() {
	# Create a filtered GOROOT tree out of symlinks,
	# excluding this package, for bug #503324.
	cp -sR /usr/lib/go goroot || die
	rm -rf goroot/src/${GO_PN} || die
	rm -rf goroot/pkg/linux_${ARCH}/${GO_PN} || die
	GOROOT=${WORKDIR}/goroot GOPATH=${WORKDIR} \
		go install -x ${GO_PN} || die
}

src_install() {
	insinto /usr/lib/go
	doins -r pkg
	insinto /usr/lib/go/src
	find src/${GO_PN} '(' -name '.git*' -o -name '.travis.yml' ')' -delete
	dodoc src/${GO_PN}/{LICENSE,README.md}
	rm src/${GO_PN}/{LICENSE,README.md}
	doins -r src/*
}
