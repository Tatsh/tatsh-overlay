# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Key Derivation Functions."
HOMEPAGE="https://github.com/robur-coop/kdf"
SRC_URI="https://github.com/robur-coop/kdf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/mirage-crypto:="
RDEPEND="${DEPEND}"
