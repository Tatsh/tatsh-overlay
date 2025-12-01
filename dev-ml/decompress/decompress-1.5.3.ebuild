# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Implementation of Zlib and GZip in OCaml."
HOMEPAGE="https://github.com/mirage/decompress"
SRC_URI="https://github.com/mirage/decompress/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/checkseum-0.2.0:=
	>=dev-ml/cmdliner-1.1.0:=
	>=dev-ml/optint-0.1.0:="
RDEPEND="${DEPEND}"
