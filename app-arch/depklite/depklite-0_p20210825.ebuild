# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

# Upstream has never tagged a release, so this is a snapshot of the default
# branch.
MY_COMMIT="83a11e57961cc95af0fdfebeb3759f82e0c11abe"

DESCRIPTION="Decompress EXE files compressed with PKLITE."
HOMEPAGE="https://github.com/hackerb9/depklite"
SRC_URI="https://github.com/hackerb9/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
