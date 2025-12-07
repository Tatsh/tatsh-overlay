# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Detect root CA certificates from the operating system."
HOMEPAGE="https://github.com/mirage/ca-certs"
SRC_URI="https://github.com/mirage/ca-certs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/bos:=
	>=dev-ml/digestif-1.2.0:=
	dev-ml/fpath:=
	dev-ml/logs:=
	>=dev-ml/mirage-crypto-1.0.0:=
	>=dev-ml/ohex-0.2.0:=
	dev-ml/ptime:=
	>=dev-ml/x509-1.0.0:="
RDEPEND="${DEPEND}"
