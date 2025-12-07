# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Encoder/Decoder of Quoted-Printable (RFC2045 & RFC2047)."
HOMEPAGE="https://github.com/mirage/pecu"
SRC_URI="https://github.com/mirage/pecu/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
