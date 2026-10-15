# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Host client for ps2link and ps2netfs on a networked PlayStation 2"
HOMEPAGE="https://github.com/ps2dev/ps2client"
SRC_URI="https://github.com/ps2dev/ps2client/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Upstream ships no license.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="-std=gnu99 ${CFLAGS} ${LDFLAGS}"
}

src_install() {
	dobin bin/fsclient bin/ps2client
	einstalldocs
}
