# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Manage Switch backups (console only)."
HOMEPAGE="https://github.com/giwty/switch-library-manager"
SRC_URI="https://github.com/giwty/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/${PN}-fix-version.patch"
	"${FILESDIR}/${PN}-fix-versions-url.patch"
	"${FILESDIR}/${PN}-no-gui-xdg.patch"
)

src_compile() {
	# go.mod declares go 1.12 and vendoring is only automatic from 1.14, so the
	# vendor directory has to be selected explicitly.
	go build -mod=vendor . || die
}

src_test() {
	go test ./... || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
