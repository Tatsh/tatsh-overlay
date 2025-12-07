# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Simple symmetric cryptography for the modern age."
HOMEPAGE="https://github.com/mirage/mirage-crypto"
SRC_URI="https://github.com/mirage/mirage-crypto/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/eqaf-0.8:="
RDEPEND="${DEPEND}"
BDEPEND=">=dev-ml/dune-configurator-2.0.0"
