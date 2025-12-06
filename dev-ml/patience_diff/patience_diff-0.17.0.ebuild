# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Patience diff algorithm."
HOMEPAGE="https://github.com/janestreet/patience_diff"
SRC_URI="https://github.com/janestreet/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/patience_diff-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/base-0.14:=
	>=dev-ml/core_kernel-0.14:=
	>=dev-ml/ppx_jane-0.14:="
RDEPEND="${DEPEND}"
