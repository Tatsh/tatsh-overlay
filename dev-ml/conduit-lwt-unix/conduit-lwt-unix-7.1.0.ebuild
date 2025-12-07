# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Network connection establishment library for Lwt_unix."
HOMEPAGE="https://github.com/mirage/ocaml-conduit"
SRC_URI="https://github.com/mirage/ocaml-conduit/archive/refs/tags/v${PV}.tar.gz -> conduit-${PV}.tar.gz"
S="${WORKDIR}/ocaml-conduit-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/ca-certs:=
	dev-ml/conduit-lwt:=
	>=dev-ml/ipaddr-4.0.0:=
	dev-ml/ipaddr-sexp:=
	dev-ml/logs:=
	>=dev-ml/lwt-5.7.0:=
	>=dev-ml/ppx_sexp_conv-0.13.0:=
	>=dev-ml/uri-1.9.4:="
RDEPEND="${DEPEND}"
