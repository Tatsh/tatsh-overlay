# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Tiny package that helps you to add CLI subcommands to your Go program"
HOMEPAGE="https://github.com/rakyll/command"
EGIT_COMMIT="0f2fed130caff9721655936b8a71d98b5252fc3a"
GO_PN=github.com/rakyll/${PN/go-/}
SRC_URI="https://${GO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
RESTRICT="strip"

LICENSE="Apache-2.0"
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
	dodoc src/${GO_PN}/README.md
	rm src/${GO_PN}/README.md
	doins -r src/*
}
