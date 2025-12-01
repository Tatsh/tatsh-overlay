# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Core matching engine for comby."
HOMEPAGE="https://github.com/comby-tools/comby"
SRC_URI="https://github.com/comby-tools/comby/archive/refs/tags/${PV}.tar.gz -> comby-${PV}.tar.gz"
S="${WORKDIR}/comby-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/bigstringaf:=
	dev-ml/core_kernel:=
	>=dev-ml/mparser-1.3:=
	dev-ml/mparser-pcre:=
	dev-ml/pcre-ocaml:=
	dev-ml/ppx_deriving:=
	>=dev-ml/ppx_deriving_yojson-3.6.0:=
	>=dev-ml/yojson-1.6.0:="
RDEPEND="${DEPEND}"
