# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="ASN.1 combinators library."
HOMEPAGE="https://github.com/mirleft/ocaml-asn1-combinators"
SRC_URI="https://github.com/mirleft/ocaml-asn1-combinators/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/ptime:=
	>=dev-ml/zarith-1.13:="
RDEPEND="${DEPEND}"
