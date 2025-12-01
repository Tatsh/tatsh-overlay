# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="JSON parsing and printing library for OCaml."
HOMEPAGE="https://github.com/ocaml-community/yojson"
SRC_URI="https://github.com/ocaml-community/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/biniou-1.2.0:=
	dev-ml/easy-format:="
RDEPEND="${DEPEND}"
BDEPEND="dev-ml/cppo"
