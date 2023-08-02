# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Collection of tools for Super Mario 64 ROM hacking (and others)."
HOMEPAGE="https://github.com/queueRAM/sm64tools"
SHA="81de9e5a8f0fa96686a16441d5b9f25742f4d17d"
SRC_URI="https://github.com/queueRAM/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/capstone
	dev-libs/libyaml
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="dev-libs/stb"

S="${WORKDIR}/${PN}-${SHA}"

DOCS=( release/sm64extend.README.txt release/n64split.README.txt README.md TODO )

src_prepare() {
	default
	sed -re 's/-Wall -Wextra //g' \
		-e 's/-s -Wl/-Wl/g' \
		-e 's/-O2//' \
		-e 's/^CFLAGS( +)=/CFLAGS ?= $(CFLAGS) /' \
		-e 's|^LDFLAGS( +)=|LDFLAGS ?= $(LDFLAGS) |' \
		-i Makefile || die
	sed -re "s|^#define CONFIGS_DIR.*|#define CONFIGS_DIR \"${EPREFIX}/usr/share/${PN}/configs\"|" \
		-i n64split.c || die
}

src_install() {
	dobin f3d f3d2obj mio0 mipsdisasm n64cksum n64graphics n64split sm64compress sm64extend \
		sm64geo sm64walk
	insinto /usr/share/${PN}
	doins -r configs
	einstalldocs
}
