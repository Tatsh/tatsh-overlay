# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

# Upstream's only tag is "r1", which is not a version number.
MY_TAG="r1"

DESCRIPTION="Dump Windows registry hives as text, one line per value."
HOMEPAGE="https://github.com/adoxa/regdump"
SRC_URI="https://github.com/adoxa/${PN}/archive/refs/tags/${MY_TAG}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_TAG}"

# Upstream ships no licence file and the source states no terms anywhere.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

src_compile() {
	# shellcheck disable=SC2046,SC2086
	edo $(tc-getCC) ${CFLAGS} ${LDFLAGS} -o "${PN}" "${PN}".c
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
