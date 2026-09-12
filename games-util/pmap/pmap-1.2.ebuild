# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_PN="PMAP"

DESCRIPTION="PlayStation 2 Mechacon Adjustment Program, for CD/DVD subsystem maintenance."
HOMEPAGE="https://github.com/ps2homebrew/PMAP"
SRC_URI="https://github.com/ps2homebrew/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

PATCHES=( "${FILESDIR}/${P}-linux-debug-stubs.patch" )

src_prepare() {
	default

	# Upstream never passes LDFLAGS when linking.
	sed -i -e 's|$(CC) -o $(ELF)|$(CC) $(LDFLAGS) -o $(ELF)|' \
		PMAP-linux/Makefile || die
}

src_compile() {
	emake -C PMAP-linux CC="$(tc-getCC)" CFLAGS="${CFLAGS} -I."
}

src_install() {
	# sys-process/procps already owns /usr/bin/pmap.
	newbin PMAP-linux/pmap "${PN}-ps2"
	dodoc README.txt Changelog.txt
}

pkg_postinst() {
	elog "The executable is installed as ${PN}-ps2 because sys-process/procps"
	elog "already owns /usr/bin/${PN}."
}
