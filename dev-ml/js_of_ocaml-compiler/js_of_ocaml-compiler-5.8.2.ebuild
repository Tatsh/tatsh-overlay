# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Compiler from OCaml bytecode to JavaScript."
HOMEPAGE="https://ocsigen.org/js_of_ocaml/"
SRC_URI="https://github.com/ocsigen/js_of_ocaml/archive/refs/tags/${PV}.tar.gz -> js_of_ocaml-${PV}.tar.gz"
S="${WORKDIR}/js_of_ocaml-${PV}"

LICENSE="GPL-2+ LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/cmdliner-1.1.0:=
	dev-ml/menhir:=
	dev-ml/menhirLib:=
	dev-ml/menhirSdk:=
	>=dev-ml/ppxlib-0.35:=
	>=dev-ml/sedlex-3.3:=
	>=dev-ml/yojson-2.1:="
RDEPEND="${DEPEND}"
