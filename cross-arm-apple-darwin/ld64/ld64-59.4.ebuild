# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit eutils flag-o-matic toolchain-funcs git-2

DESCRIPTION="Apple's Linker tool."
HOMEPAGE="https://github.com/tatsh/xchain"
EGIT_REPO_URI="git://github.com/tatsh/xchain.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_configure() {
	chmod +x configure
	local target="arm-apple-darwin"

	# No optimisations!
	filter-flags -fomit-frame-pointer
	filter-flags -pipe
	filter-flags -O*
	filter-flags -mmmx*
	filter-flags -msse*
	filter-flags -march=*
	replace-cpu-flags

	# Must be built in 32-bit mode
	append-flags "-m32 -w"
	append-ldflags "-m32"

	cd "${WORKDIR}/${PN}-59.4/odcctools-9.2-ld"
	econf --enable-ld64 --target=${target}
}

src_compile() {
	cd "${WORKDIR}/${PN}-59.4/odcctools-9.2-ld"
	emake
}

src_install() {
	cd "${WORKDIR}/${PN}-59.4/odcctools-9.2-ld/ld64"
	emake DESTDIR="${D}" install
	ln -s "${D}/usr/bin/arm-apple-darwin-ld64" "${D}/usr/bin/arm-apple-darwin-ld"
}
