# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dune

DESCRIPTION="Pin current process to given core number."
HOMEPAGE="https://github.com/UnixJunkie/cpu"
SRC_URI="https://github.com/UnixJunkie/cpu/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

src_prepare() {
	default
	eautoreconf
}
