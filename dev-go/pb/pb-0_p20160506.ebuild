# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

EGO_SRC=github.com/cheggaaa/pb
EGO_PN=${EGO_SRC}/...

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm64"
	EGIT_COMMIT="c089c0e183064d83038db7c2ae1b711fb2e747a4"
	SRC_URI="https://${EGO_SRC}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Console progress bar for Go"
HOMEPAGE="https://github.com/cheggaaa/pb"
LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+appengine examples"
DEPEND=""
RDEPEND=""

src_prepare() {
	local prefix="${WORKDIR}/${P}/src/${EGO_SRC}"
	rm -f "${prefix}/.gitignore" \
		"${prefix}/.travis.yml" \
		"${prefix}/pb_win.go"
	! use examples && rm -f "${prefix}/example_"*.go
	! use appengine && rm -f "${prefix}/pb_appengine.go"
	default
}

src_install() {
	local prefix="${WORKDIR}/${P}/src/${EGO_SRC}"
	dodoc "${prefix}/LICENSE" "${prefix}/README.md"
	rm "${prefix}/LICENSE" "${prefix}/README.md"

	# This is implemented because golang_install_pkgs assumes a pkg and src
	# directory. There is no pkg directory.
	ego_pn_check
	set -- env GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go install -v -work -x ${EGO_BUILD_FLAGS} "${EGO_PN}"
	echo "$@"
	"$@" || die

	insinto "$(get_golibdir)"
	insopts -m0644 -p # preserve timestamps for bug 551486
	doins -r src
}
