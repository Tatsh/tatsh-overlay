# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="URI library with sexp support."
HOMEPAGE="https://github.com/mirage/ocaml-uri"
SRC_URI="https://github.com/mirage/ocaml-uri/archive/refs/tags/v${PV}.tar.gz -> uri-${PV}.tar.gz"
S="${WORKDIR}/ocaml-uri-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/ppx_sexp_conv-0.13.0:=
	dev-ml/sexplib0:=
	dev-ml/uri:="
RDEPEND="${DEPEND}"
