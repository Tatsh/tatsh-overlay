# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A lock-free thread-safe integer keyed hash table."
HOMEPAGE="https://github.com/ocaml-multicore/thread-table"
SRC_URI="https://github.com/ocaml-multicore/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
