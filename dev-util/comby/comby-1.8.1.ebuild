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

DEPEND="dev-ml/cohttp:=[lwt-unix]
	dev-ml/lwt:=
	>=dev-ml/mparser-1.3:=[pcre]
	>=dev-ml/parany-12.0.3:=
	>=dev-ml/patience_diff-0.14:=
	<dev-ml/patience_diff-0.15:=
	>=dev-ml/ppx_deriving_yojson-3.6.0:=
	dev-ml/ppx_expect:=
	dev-ml/ppx_sexp_message:=
	dev-ml/tar:=[unix]
	>=dev-ml/toml-6.0.0:=
	>=dev-ml/yojson-1.6.0:=
	<dev-ml/yojson-2.0.0:="
RDEPEND="${DEPEND}"
