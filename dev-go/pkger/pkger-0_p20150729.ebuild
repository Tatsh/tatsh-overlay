# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

MY_EGO_SRC=github.com/odeke-em/xon
EGO_SRC=github.com/odeke-em/xon/pkger/src
EGO_PN=${EGO_SRC}/...

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm64"
	EGIT_COMMIT="0af932ae72e246898c3a49eab51137bb38ccdbf0"
	SRC_URI="https://${MY_EGO_SRC}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Get OS, Go and Git commit information of a Go package."
HOMEPAGE="https://github.com/odeke-em/xon/pkger"
LICENSE="MIT"
SLOT="0/${PV}"
IUSE=""
DEPEND=""
RDEPEND=""
STRIP_MASK="*.a"

src_prepare() {
	local prefix="${WORKDIR}/${P}/src/${EGO_SRC}"
	rm -f "${prefix}/.gitignore"
	rm -fR "${prefix}/cprefix"
	default
}

src_install() {
	local prefix="${WORKDIR}/${P}/src/${EGO_SRC}"
	dodoc "${prefix}/LICENSE" "${prefix}/pkger/README.md"
	rm -f "${prefix}/LICENSE" "${prefix}/pkger/README.md"
	golang-build_src_install
}
