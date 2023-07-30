# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A simple monadic parser combinator library for OCaml."
HOMEPAGE="https://github.com/murmour/mparser"
SRC_URI="https://github.com/murmour/mparser/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt pcre"

DEPEND="dev-ml/pcre-ocaml:="

src_install() {
	dune-install "${PN}"
	use pcre && dune-install "${PN}-pcre"
}
