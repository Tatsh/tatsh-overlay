# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="SDK library for Menhir."
HOMEPAGE="https://gitlab.inria.fr/fpottier/menhir"
SRC_URI="https://gitlab.inria.fr/fpottier/menhir/-/archive/${PV}/menhir-${PV}.tar.gz"
S="${WORKDIR}/menhir-${PV}"

LICENSE="LGPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
