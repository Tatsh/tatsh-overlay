# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Adler-32, CRC32 and CRC32-C implementation in C and OCaml."
HOMEPAGE="https://github.com/mirage/checkseum"
SRC_URI="https://github.com/mirage/checkseum/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/optint-0.3.0:="
RDEPEND="${DEPEND}"
BDEPEND="dev-ml/dune-configurator"
