# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Over 500 crates, so they ship as a tarball generated with
# 'pycargoebuild --crate-tarball' rather than individual CRATES entries.
CRATES=""

RUST_MIN_VER="1.88.0"

inherit cargo

DESCRIPTION="Fast, async link checker for Markdown, HTML and text files."
HOMEPAGE="https://lychee.cli.rs https://github.com/lycheeverse/lychee"
SRC_URI="https://github.com/lycheeverse/${PN}/archive/refs/tags/${PN}-v${PV}.tar.gz
	-> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-crates.tar.xz"
S="${WORKDIR}/${PN}-${PN}-v${PV}"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD CDLA-Permissive-2.0 ISC MIT MPL-2.0 openssl
	Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror
	test"

src_compile() {
	# The crate in lychee-bin/ is itself named "lychee".
	cargo_src_compile -p "${PN}"
}

src_install() {
	cargo_src_install --path "${PN}-bin"
	einstalldocs
}
