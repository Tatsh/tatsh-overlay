# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Declarative events and signals for OCaml."
HOMEPAGE="https://github.com/ocsigen/reactiveData"
SRC_URI="https://github.com/ocsigen/reactiveData/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/react-1.2.1:="
RDEPEND="${DEPEND}"
