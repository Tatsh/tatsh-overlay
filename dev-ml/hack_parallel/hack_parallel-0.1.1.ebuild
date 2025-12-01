# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Parallel and shared memory library."
HOMEPAGE="https://github.com/rvantonder/hack-parallel"
SRC_URI="https://github.com/rvantonder/hack_parallel/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/core:=
	dev-ml/ppx_deriving:="
RDEPEND="${DEPEND}"

src_compile() {
	emake libhp.a
	dune_src_compile
}
