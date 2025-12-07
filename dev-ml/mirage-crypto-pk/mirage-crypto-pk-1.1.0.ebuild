# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Public-key cryptography (RSA, DSA, DH)."
HOMEPAGE="https://github.com/mirage/mirage-crypto"
SRC_URI="https://github.com/mirage/mirage-crypto/archive/refs/tags/v${PV}.tar.gz -> mirage-crypto-${PV}.tar.gz"
S="${WORKDIR}/mirage-crypto-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/digestif-1.2.0:=
	>=dev-ml/eqaf-0.8:=
	dev-ml/mirage-crypto:=
	dev-ml/mirage-crypto-rng:=
	>=dev-ml/zarith-1.13:="
RDEPEND="${DEPEND}"
