# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

EGO_SRC=github.com/odeke-em/drive
EGO_PN=${EGO_SRC}/...

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm64"
	EGIT_COMMIT="cd62d0afcf2ee48965f903857a5a7058427b30fe"
	SRC_URI="https://${EGO_SRC}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Pull or push Google Drive files (fork)"
HOMEPAGE="https://github.com/odeke-em/drive"
STRIP_MASK="*.a"
LICENSE="MIT"
SLOT="0/${PV}"
IUSE=""
DEPEND="dev-go/go-oauth2
dev-go/pb
dev-go/go-isatty
dev-go/go-cli-spinner
dev-go/statos
dev-go/pkger
dev-go/odeke-em-log
dev-go/go-command"
RDEPEND="${DEPEND}"
