# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="PCRE support for mparser."
HOMEPAGE="https://github.com/murmour/mparser"
SRC_URI="https://github.com/murmour/mparser/archive/refs/tags/${PV}.tar.gz -> mparser-${PV}.tar.gz"
S="${WORKDIR}/mparser-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/mparser:=
	dev-ml/pcre-ocaml:="
RDEPEND="${DEPEND}"
