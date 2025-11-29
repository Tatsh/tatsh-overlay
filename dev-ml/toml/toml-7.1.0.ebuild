# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml library for TOML."
HOMEPAGE="https://ocaml-toml.github.io/To.ml/"
SRC_URI="https://github.com/ocaml-toml/To.ml/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/To.ml-${PV}"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

BDEPEND="dev-ml/menhir:="
DEPEND=">=dev-ml/iso8601-0.2:="
