# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Network connection establishment library."
HOMEPAGE="https://github.com/mirage/ocaml-conduit"
SRC_URI="https://github.com/mirage/ocaml-conduit/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/astring:=
	>=dev-ml/ipaddr-4.0.0:=
	dev-ml/ipaddr-sexp:=
	>=dev-ml/logs-0.5.0:=
	>=dev-ml/ppx_sexp_conv-0.13.0:=
	dev-ml/sexplib0:=
	dev-ml/uri:="
RDEPEND="${DEPEND}"
