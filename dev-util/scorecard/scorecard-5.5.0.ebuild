# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

DESCRIPTION="Security health metrics for open source projects."
HOMEPAGE="https://github.com/ossf/scorecard"
SRC_URI="https://github.com/ossf/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"

# Apache-2.0 is upstream's own. The rest are the licences of the vendored
# dependencies, including the CC ones covering documentation shipped inside
# them.
LICENSE="Apache-2.0 BSD BSD-2 CC-BY-4.0 CC-BY-SA-4.0 ISC MIT MPL-2.0 Unlicense"
SLOT="0"
KEYWORDS="~amd64"
# The end to end tests are ginkgo based and need a real GitHub token.
RESTRICT="mirror test"

BDEPEND=">=dev-lang/go-1.25.6"

src_compile() {
	# Upstream's Makefile takes these from git, which a release tarball cannot
	# answer for, so they are passed explicitly. gitCommit is left at its
	# default of unknown rather than invented. The Makefile also passes -a and
	# -extldflags=-static, both of which fight the PIE build go-env.eclass sets
	# up.
	local ldflags=(
		-X "sigs.k8s.io/release-utils/version.gitVersion=v${PV}"
		-X 'sigs.k8s.io/release-utils/version.gitTreeState=clean'
	)
	# Only claim a build date when there is a real one to claim.
	[[ ${SOURCE_DATE_EPOCH} ]] &&
		ldflags+=( -X "sigs.k8s.io/release-utils/version.buildDate=${SOURCE_DATE_EPOCH}" )
	CGO_ENABLED=0 go build -tags netgo -ldflags "${ldflags[*]}" || die

	# Cobra generates these; the built binary is the only thing that knows its
	# own command tree.
	local shell
	for shell in bash fish zsh; do
		"./${PN}" completion "${shell}" > "${T}/${PN}.${shell}" || die
	done
}

src_install() {
	dobin "${PN}"
	einstalldocs

	newbashcomp "${T}/${PN}.bash" "${PN}"
	newzshcomp "${T}/${PN}.zsh" "_${PN}"
	newfishcomp "${T}/${PN}.fish" "${PN}.fish"
}

pkg_postinst() {
	elog "Scanning a GitHub repository needs a token in GITHUB_AUTH_TOKEN,"
	elog "GITHUB_TOKEN, GH_TOKEN or GH_AUTH_TOKEN. Without one the anonymous"
	elog "rate limit of 60 requests an hour is reached almost immediately."
}
