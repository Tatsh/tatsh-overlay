# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="MirageOS signature for key/value stores"
HOMEPAGE="https://github.com/mirage/mirage-kv"
SRC_URI="https://github.com/mirage/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/lwt-4.0.0:=
	>=dev-ml/fmt-0.8.7:=
	>=dev-ml/optint-0.2.0
	>=dev-ml/ptime-1.0.0"
RDEPEND="${DEPEND}"
