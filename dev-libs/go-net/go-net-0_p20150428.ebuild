# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Go supplementary network libraries"
HOMEPAGE="https://godoc.org/golang.org/x/net"
GO_PN=golang.org/x/${PN/go-/}
EGIT_REPO_URI="https://go.googlesource.com/net"
EGIT_COMMIT="a8c61998a557a37435f719980da368469c10bfed"
RESTRICT="strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_compile() {
	# Create a filtered GOROOT tree out of symlinks,
	# excluding this package, for bug #503324.
	cp -sR /usr/lib/go goroot || die
	rm -rf goroot/src/${GO_PN} || die
	rm -rf goroot/pkg/linux_${ARCH}/${GO_PN} || die
	mkdir -p src/golang.org/x
	cp -vfR ${P} src/${GO_PN}
	for i in context dict html icmp idna internal/iana internal/nettest ipv4 \
		ipv6 netutil proxy publicsuffix webdav websocket; do
		GOROOT=${WORKDIR}/goroot GOPATH=${WORKDIR} \
			go install -x ${GO_PN}/${i} || die
	done
}

src_install() {
	insinto /usr/lib/go
	doins -r pkg
	insinto /usr/lib/go/src
	find src/${GO_PN} -type f '(' -name '.git*' -o -name '.travis.yml' ')' -delete
	rm -fR src/${GO_PN}/.git
	dodoc src/${GO_PN}/{AUTHORS,CONTRIBUTING.md,CONTRIBUTORS,LICENSE,PATENTS,README}
	rm src/${GO_PN}/{AUTHORS,CONTRIBUTING.md,CONTRIBUTORS,LICENSE,PATENTS,README}
	doins -r src/*
}
