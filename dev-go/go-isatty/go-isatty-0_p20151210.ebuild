# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

EGO_SRC=github.com/mattn/go-isatty
EGO_PN=${EGO_SRC}/...

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm64 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
	EGIT_COMMIT="56b76bdf51f7708750eac80fa38b952bb9f32639"
	SRC_URI="https://${EGO_SRC}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="isatty() for Go"
HOMEPAGE="https://github.com/mattn/go-isatty"
LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+appengine example"
DEPEND=""
RDEPEND=""

src_prepare() {
	local prefix="${WORKDIR}/${P}/src/${EGO_SRC}"
	rm -f "${prefix}/doc.go" "${prefix}/.gitignore" \
		"${prefix}/.travis.yml"
	if ! use example; then
		rm -f "${prefix}/_example"
	fi
	if ! use appengine; then
		rm -f "${prefix}/isatty_appengine.go"
	fi

	if ! [[ ${CHOST} == *bsd* ]] && \
	   ! [[ ${CHOST} == *-darwin* ]]; then
		rm rm -f "${prefix}/isatty_bsd.go"
	fi
	! [[ ${CHOST} == *-solaris* ]] && rm -f "${prefix}/isatty_solaris.go"
	! [[ ${CHOST} == *-winnt* ]] && rm -f "${prefix}/isatty_windows.go"

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
