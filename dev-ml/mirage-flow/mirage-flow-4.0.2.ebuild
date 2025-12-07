# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Flow implementations and combinators for MirageOS."
HOMEPAGE="https://github.com/mirage/mirage-flow"
SRC_URI="https://github.com/mirage/mirage-flow/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/cstruct-4.0.0:=
	dev-ml/fmt:=
	>=dev-ml/lwt-4.0.0:="
RDEPEND="${DEPEND}"
