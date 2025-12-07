# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Public Key Infrastructure (RFC 5280, PKCS) purely in OCaml."
HOMEPAGE="https://github.com/mirleft/ocaml-x509"
SRC_URI="https://github.com/mirleft/ocaml-x509/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/asn1-combinators-0.3.1:=
	>=dev-ml/ocaml-base64-3.3.0:=
	>=dev-ml/domain-name-0.3.0:=
	>=dev-ml/fmt-0.8.7:=
	>=dev-ml/gmap-0.3.0:=
	>=dev-ml/ipaddr-5.2.0:=
	>=dev-ml/kdf-1.0.0:=
	dev-ml/logs:=
	>=dev-ml/mirage-crypto-1.0.0:=
	>=dev-ml/mirage-crypto-ec-0.10.7:=
	dev-ml/mirage-crypto-pk:=
	dev-ml/mirage-crypto-rng:=
	>=dev-ml/ohex-0.2.0:=
	dev-ml/ptime:="
RDEPEND="${DEPEND}"
