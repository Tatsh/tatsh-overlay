# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Cryptographically secure PRNG."
HOMEPAGE="https://github.com/mirage/mirage-crypto"
SRC_URI="https://github.com/mirage/mirage-crypto/archive/refs/tags/v${PV}.tar.gz -> mirage-crypto-${PV}.tar.gz"
S="${WORKDIR}/mirage-crypto-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/digestif-1.1.4:=
	dev-ml/duration:=
	dev-ml/logs:=
	dev-ml/mirage-crypto:="
RDEPEND="${DEPEND}"
BDEPEND=">=dev-ml/dune-configurator-2.0.0"
