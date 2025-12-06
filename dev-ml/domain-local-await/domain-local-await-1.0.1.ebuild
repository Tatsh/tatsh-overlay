# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A scheduler independent blocking mechanism."
HOMEPAGE="https://github.com/ocaml-multicore/ocaml-uring"
SRC_URI="https://github.com/ocaml-multicore/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/thread-table-1.0.0"
RDEPEND="${DEPEND}"
