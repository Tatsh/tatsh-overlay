# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Unix support for Miou concurrency library."
HOMEPAGE="https://git.robur.coop/robur/miou"
SRC_URI="https://github.com/robur-coop/miou/archive/refs/tags/v${PV}.tar.gz -> miou-${PV}.tar.gz"
S="${WORKDIR}/miou-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="dev-ml/miou:="
RDEPEND="${DEPEND}"
