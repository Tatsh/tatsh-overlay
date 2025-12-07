# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="X.509 trust anchors extracted from Mozilla's NSS."
HOMEPAGE="https://github.com/mirage/ca-certs-nss"
SRC_URI="https://github.com/mirage/ca-certs-nss/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/digestif-1.2.0:=
	>=dev-ml/mirage-ptime-4.0.0:=
	>=dev-ml/x509-1.0.0:="
RDEPEND="${DEPEND}"
BDEPEND="dev-ml/bos
	>=dev-ml/cmdliner-1.1.0
	>=dev-ml/fmt-0.8.7
	dev-ml/logs"
