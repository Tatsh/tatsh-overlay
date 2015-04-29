# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Auto-generated Google APIs for Go"
HOMEPAGE="https://code.googlesource.com/google-api-go-client"
GO_PN=google.golang.org/api
EGIT_REPO_URI="https://code.googlesource.com/google-api-go-client"
EGIT_COMMIT="f99e8ddfd771d4540a11c84a0ca65aa1e50e03f6"
RESTRICT="strip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/go-1.4.2
dev-libs/go-net"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_compile() {
	# Create a filtered GOROOT tree out of symlinks,
	# excluding this package, for bug #503324.
	cp -sR /usr/lib/go goroot || die
	rm -rf goroot/src/${GO_PN} || die
	rm -rf goroot/pkg/linux_${ARCH}/${GO_PN} || die
	mkdir -p src/google.golang.org
	cp -vfR ${P} src/${GO_PN}
	# TODO This is only for building odeke-em/drive
	for i in drive/v2 googleapi; do
		GOROOT=${WORKDIR}/goroot GOPATH=${WORKDIR} \
			go install -x ${GO_PN}/${i} || die
	done
}

src_install() {
	insinto /usr/lib/go
	doins -r pkg
	insinto /usr/lib/go/src
	find src/${GO_PN} -type f '(' -name '.git*' -o -name '.travis.yml' ')' -delete
	rm -fR src/${GO_PN}/.git src/${GO_PN}/examples
	dodoc src/${GO_PN}/{AUTHORS,CONTRIBUTING.md,CONTRIBUTORS,GettingStarted.md,LICENSE,NOTES,README.md,TODO}
	rm src/${GO_PN}/{AUTHORS,CONTRIBUTING.md,CONTRIBUTORS,GettingStarted.md,LICENSE,NOTES,README.md,TODO}
	doins -r src/*
}
