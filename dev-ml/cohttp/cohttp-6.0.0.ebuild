# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="HTTP client and server library for OCaml."
HOMEPAGE="https://github.com/mirage/ocaml-cohttp"
SRC_URI="https://github.com/mirage/ocaml-cohttp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/ocaml-base64-3.1.0:=
	dev-ml/http:=
	dev-ml/logs:=
	>=dev-ml/ppx_sexp_conv-0.13.0:=
	>=dev-ml/re-1.9.0:=
	dev-ml/sexplib0:=
	dev-ml/stringext:=
	>=dev-ml/uri-2.0.0:=
	dev-ml/uri-sexp:="
RDEPEND="${DEPEND}"
