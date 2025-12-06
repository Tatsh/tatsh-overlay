# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="POSIX time functions for MirageOS."
HOMEPAGE="https://github.com/mirage/mirage-ptime"
SRC_URI="https://github.com/mirage/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/ptime:="
RDEPEND="${DEPEND}"
