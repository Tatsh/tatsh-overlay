# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Bindings to io_uring for OCaml."
HOMEPAGE="https://github.com/ocaml-multicore/ocaml-uring"
SRC_URI="https://github.com/ocaml-multicore/ocaml-${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="sys-libs/liburing
	>=dev-ml/cstruct-6.0.1
	>=dev-ml/fmt-0.8.10
	>=dev-ml/optint-0.1.0"
RDEPEND="${DEPEND}"
