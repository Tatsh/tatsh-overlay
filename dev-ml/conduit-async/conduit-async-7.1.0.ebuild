# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Network connection establishment library for Async."
HOMEPAGE="https://github.com/mirage/ocaml-conduit"
SRC_URI="https://github.com/mirage/ocaml-conduit/archive/refs/tags/v${PV}.tar.gz -> conduit-${PV}.tar.gz"
S="${WORKDIR}/ocaml-conduit-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/async-0.15.0:=
	dev-ml/conduit:=
	>=dev-ml/core-0.15.0:=
	>=dev-ml/ipaddr-3.0.0:=
	>=dev-ml/ipaddr-sexp-4.0.0:=
	>=dev-ml/ppx_here-0.9.0:=
	>=dev-ml/ppx_sexp_conv-0.13.0:=
	dev-ml/sexplib0:=
	>=dev-ml/uri-4.0.0:="
RDEPEND="${DEPEND}"
