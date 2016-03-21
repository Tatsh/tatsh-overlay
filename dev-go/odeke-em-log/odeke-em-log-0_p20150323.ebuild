# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

EGO_SRC=github.com/odeke-em/log
EGO_PN=${EGO_SRC}/...

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm64"
	EGIT_COMMIT="cad53c4565a0b0304577bd13f3862350bdc5f907"
	SRC_URI="https://${EGO_SRC}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Go logging utility"
HOMEPAGE="https://github.com/odeke-em/log"
LICENSE="MIT"
SLOT="0/${PV}"
IUSE=""
DEPEND=""
RDEPEND=""

src_prepare() {
	local prefix="${WORKDIR}/${P}/src/${EGO_SRC}"
	rm -f "${prefix}/log_test.go" "${prefix}/.gitignore" \
		"${prefix}/.travis.yml"
	rm -fR "${prefix}/code-examples/"
	default
}

src_install() {
	local prefix="${WORKDIR}/${P}/src/${EGO_SRC}"
	dodoc "${prefix}/LICENSE"
	rm "${prefix}/LICENSE"

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
