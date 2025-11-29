# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Yet another implementation of fork and exec and related functionality."
HOMEPAGE="https://github.com/janestreet/shell"
SRC_URI="https://github.com/janestreet/shell/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/spawn-0.15:=
	>=dev-ml/textutils-0.16:=
	<dev-ml/textutils-0.17:=
	>=dev-ml/core-0.16:=
	<dev-ml/core-0.17:=
	>=dev-ml/ppx_jane-0.16:=
	<dev-ml/ppx_jane-0.17:="
