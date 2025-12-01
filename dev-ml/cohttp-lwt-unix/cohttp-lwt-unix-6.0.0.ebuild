# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="CoHTTP implementation for Unix using Lwt."
HOMEPAGE="https://github.com/mirage/ocaml-cohttp"
SRC_URI="https://github.com/mirage/ocaml-cohttp/archive/refs/tags/v${PV}.tar.gz -> cohttp-${PV}.tar.gz"
S="${WORKDIR}/ocaml-cohttp-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/cmdliner-1.1.0:=
	dev-ml/cohttp:=
	>=dev-ml/fmt-0.8.2:=
	dev-ml/logs:=
	>=dev-ml/lwt-3.0.0:=
	dev-ml/magic-mime:=
	>=dev-ml/ppx_sexp_conv-0.13.0:="
RDEPEND="${DEPEND}"
