# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra-superfx"

inherit ghidra-extension

DESCRIPTION="Ghidra processor module for the Nintendo SuperFX co-processor."
HOMEPAGE="https://github.com/ChekeEdd/ghidra-superfx"
SRC_URI="https://github.com/ChekeEdd/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="BSD"
KEYWORDS="~amd64"

src_prepare() {
	ghidra-extension_src_prepare

	# A developer tool that drives an AI review plugin, not a Ghidra script:
	# Ghidra reads scripts from ghidra_scripts, which this module does not have.
	rm -r scripts || die

	# Committed build output. The eclass compiles the slaspec itself.
	rm data/languages/superfx.sla || die
}
