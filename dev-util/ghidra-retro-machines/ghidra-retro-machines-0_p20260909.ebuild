# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra-retro-machines"

inherit ghidra-extension

# Upstream has never tagged a release, so this is a snapshot of the default
# branch.
MY_COMMIT="20dd96067b86396663155e5a1d97b346cd0bd3df"

DESCRIPTION="Ghidra processor modules and loaders for retro home computers."
HOMEPAGE="https://github.com/CBongo/ghidra-retro-machines"
SRC_URI="https://github.com/CBongo/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
