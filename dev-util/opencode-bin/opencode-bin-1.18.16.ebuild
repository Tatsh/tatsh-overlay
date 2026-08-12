# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The open source coding agent."
HOMEPAGE="https://opencode.ai https://github.com/anomalyco/opencode"
SRC_URI="https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-linux-x64.tar.gz -> ${P}-amd64.tar.gz"
S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

# opencode prefers a system rg on PATH and otherwise downloads ripgrep at
# runtime into its data directory.
RDEPEND="sys-apps/ripgrep"

QA_PREBUILT="usr/bin/opencode"

src_install() {
	dobin opencode
}
