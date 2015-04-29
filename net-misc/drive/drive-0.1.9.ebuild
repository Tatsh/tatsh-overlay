# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Pull or push Google Drive files (fork)"
HOMEPAGE="https://github.com/odeke-em/drive"
GO_PN=github.com/odeke-em/${PN}
SRC_URI="https://${GO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/go-1.4.2
dev-libs/goauth2
dev-libs/pb
dev-libs/go-isatty
dev-libs/go-cli-spinner
dev-libs/statos
dev-libs/pkger
dev-libs/odeke-log
dev-libs/google-api-go-client
dev-libs/go-command"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	default_src_unpack
	mkdir -p src/${GO_PN%/*} || die
	mv ${P} src/${GO_PN} || die
	pushd src/${GO_PN}
		epatch "${FILESDIR}/fix-back-to-google.patch" || die "Patch failed"
	popd
}

src_compile() {
	# Create a filtered GOROOT tree out of symlinks,
	# excluding this package, for bug #503324.
	cp -sR /usr/lib/go goroot || die
	rm -rf goroot/src/${GO_PN} || die
	rm -rf goroot/pkg/linux_${ARCH}/${GO_PN} || die
	for i in src config cmd/drive; do
		GOROOT=${WORKDIR}/goroot GOPATH=${WORKDIR} \
			go install -x ${GO_PN}/${i} || die
	done
}

src_install() {
	insinto /usr/lib/go
	doins -r pkg
	insinto /usr/lib/go/src
	find src/${GO_PN} '(' -name '.git*' -o -name '.travis.yml' ')' -delete
	dodoc src/${GO_PN}/{README.md,LICENSE}
	rm src/${GO_PN}/{README.md,LICENSE}
	doins -r src/*
	exeinto /usr/bin
	doexe bin/drive
}
