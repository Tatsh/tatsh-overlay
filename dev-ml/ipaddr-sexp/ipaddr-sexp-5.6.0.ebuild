# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="IP address manipulation library with sexp support."
HOMEPAGE="https://github.com/mirage/ocaml-ipaddr"
SRC_URI="https://github.com/mirage/ocaml-ipaddr/archive/refs/tags/v${PV}.tar.gz -> ipaddr-${PV}.tar.gz"
S="${WORKDIR}/ocaml-ipaddr-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/ipaddr:=
	>=dev-ml/ppx_sexp_conv-0.9.0:=
	dev-ml/sexplib0:="
RDEPEND="${DEPEND}"
