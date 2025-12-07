# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Elliptic Curve Cryptography with primitives from Fiat."
HOMEPAGE="https://github.com/mirage/mirage-crypto"
SRC_URI="https://github.com/mirage/mirage-crypto/archive/refs/tags/v${PV}.tar.gz -> mirage-crypto-${PV}.tar.gz"
S="${WORKDIR}/mirage-crypto-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/digestif-1.2.0:=
	>=dev-ml/eqaf-0.7:=
	dev-ml/mirage-crypto-rng:="
RDEPEND="${DEPEND}"
BDEPEND="dev-ml/dune-configurator"
