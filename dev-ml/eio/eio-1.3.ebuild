# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Decode and encode tar format files in pure OCaml."
HOMEPAGE="https://github.com/ocaml-multicore/eio"
SRC_URI="https://github.com/ocaml-multicore/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/bigstringaf-0.9.0
	>=dev-ml/cstruct-6.0.1
	dev-ml/lwt-dllist:=
	>=dev-ml/optint-0.1.0
	>=dev-ml/psq-0.2.0
	>=dev-ml/fmt-0.8.9
	>=dev-ml/hmap-0.8.1
	>=dev-ml/domain-local-await-0.1.0
	>=dev-ml/mtime-2.0.0
	dev-ml/uring:=
	dev-ml/iomux:="
RDEPEND="${DEPEND}"
