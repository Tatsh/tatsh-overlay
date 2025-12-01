# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Decode and encode tar format files in pure OCaml."
HOMEPAGE="https://github.com/mirage/ocaml-tar"
SRC_URI="https://github.com/mirage/ocaml-tar/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt unix"

DEPEND=">=dev-ml/decompress-1.5.1:=
	unix? ( >=dev-ml/lwt-5.7.0:= )"
RDEPEND="${DEPEND}"
