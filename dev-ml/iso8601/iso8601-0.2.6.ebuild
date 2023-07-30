# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Parser and printer for date-times in ISO8601."
HOMEPAGE="https://ocaml-community.github.io/ISO8601.ml"
SRC_URI="https://github.com/ocaml-community/ISO8601.ml/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

S="${WORKDIR}/ISO8601.ml-${PV}"

src_prepare() {
	default
	edune subst
}

src_install() {
	dune-install ISO8601
}
