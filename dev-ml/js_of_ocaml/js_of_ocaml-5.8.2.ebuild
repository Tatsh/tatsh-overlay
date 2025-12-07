# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Compiler from OCaml bytecode to JavaScript."
HOMEPAGE="https://ocsigen.org/js_of_ocaml/"
SRC_URI="https://github.com/ocsigen/js_of_ocaml/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/js_of_ocaml-compiler:=
	>=dev-ml/ppxlib-0.35:="
RDEPEND="${DEPEND}"
