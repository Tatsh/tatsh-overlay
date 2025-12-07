# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Composable concurrency primitives for OCaml."
HOMEPAGE="https://git.robur.coop/robur/miou"
SRC_URI="https://github.com/robur-coop/miou/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
