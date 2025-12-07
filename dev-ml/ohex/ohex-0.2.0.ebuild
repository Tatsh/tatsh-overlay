# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Hexadecimal encoding and decoding."
HOMEPAGE="https://git.robur.coop/robur/ohex"
SRC_URI="https://github.com/robur-coop/ohex/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
