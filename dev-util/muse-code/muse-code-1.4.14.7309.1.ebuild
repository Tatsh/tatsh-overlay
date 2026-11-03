# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream versions look like 1.4.7-R6101.1.
MY_PV="$(ver_cut 1-3)-R$(ver_cut 4-)"

DESCRIPTION="Meta's interactive terminal coding agent"
HOMEPAGE="https://dev.meta.ai/"
# The upstream installer drops a self-updating launcher into ~/.local/bin; this
# installs the static binary it downloads instead.
SRC_URI="https://lookaside.facebook.com/lookaside/muse/download/?channel=muse&version=${MY_PV}&file=muse-x86-linux
	-> ${P}-amd64"
S="${WORKDIR}"

LICENSE="Meta-Model-API-ToS"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip test"

QA_PREBUILT="usr/bin/muse"

src_unpack() {
	cp "${DISTDIR}/${P}-amd64" "${S}/muse" || die
}

src_install() {
	dobin muse
}
