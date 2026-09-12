# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

# Upstream has never tagged a release, so this is a snapshot of the default
# branch.
MY_COMMIT="066aac7be3b27813c221d3b03621ad6dfaecd285"

DESCRIPTION="Decompress EXE files compressed with LZEXE 0.90/0.91."
HOMEPAGE="https://github.com/mywave82/unlzexe"
SRC_URI="https://github.com/mywave82/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

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
