# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Base MirageOS runtime library."
HOMEPAGE="https://github.com/mirage/mirage"
SRC_URI="https://github.com/mirage/mirage/archive/refs/tags/v${PV}.tar.gz -> mirage-${PV}.tar.gz"
S="${WORKDIR}/mirage-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/cmdliner-1.2.0:=
	>=dev-ml/ipaddr-5.5.0:=
	>=dev-ml/logs-0.7.0:=
	>=dev-ml/lwt-4.0.0:="
RDEPEND="${DEPEND}"
