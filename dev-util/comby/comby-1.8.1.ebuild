# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Code rewrite tool for structural search and replace."
HOMEPAGE="https://comby.dev/"
SRC_URI="https://github.com/comby-tools/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-db/sqlite
	dev-libs/gmp
	dev-libs/libev
	dev-libs/libpcre2
	virtual/zlib
	dev-ml/cohttp-lwt-unix
	=dev-ml/comby-kernel-${PV}:=
	=dev-ml/comby-semantic-${PV}:=
	dev-ml/core:=
	dev-ml/hack_parallel:=
	dev-ml/lwt:=
	dev-ml/lwt_react:=
	dev-ml/lwt_ssl:=
	dev-ml/mparser:=
	>=dev-ml/mparser-pcre-1.3:=
	>=dev-ml/parany-12.0.3:=
	>=dev-ml/patience_diff-0.14:=
	dev-ml/ppx_deriving:=
	dev-ml/pcre-ocaml:=
	>=dev-ml/ppx_deriving_yojson-3.6.0:=
	dev-ml/ppx_expect:=
	dev-ml/ppx_sexp_message:=
	dev-ml/shell:=
	dev-ml/tar:=
	dev-ml/tar-unix:=
	dev-ml/pcre-ocaml:=
	>=dev-ml/toml-6.0.0:=
	>=dev-ml/yojson-1.6.0:="
RDEPEND="${DEPEND}"
