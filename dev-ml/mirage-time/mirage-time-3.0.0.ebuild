# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Time operations for MirageOS."
HOMEPAGE="https://github.com/mirage/mirage-time"
SRC_URI="https://github.com/mirage/mirage-time/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/lwt-4.0.0:="
RDEPEND="${DEPEND}"
