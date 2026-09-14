# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="GhidraOrbis"

inherit ghidra-extension

# Upstream tags builds as "1.0" followed by a build number. Portage compares a component with a
# leading zero as a string, which puts 1.096 above 1.0144, so the version drops that zero and the
# tag is rebuilt from it.
MY_PV="1.0${PV#1.}"

DESCRIPTION="Ghidra loader for PlayStation 4 Orbis OS executables."
HOMEPAGE="https://github.com/astrelsky/GhidraOrbis"
SRC_URI="https://github.com/astrelsky/${GHIDRA_EXT_NAME}/archive/refs/tags/${MY_PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${MY_PV}"

LICENSE="GPL-3"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${P}-ghidra12-exporter.patch" )
