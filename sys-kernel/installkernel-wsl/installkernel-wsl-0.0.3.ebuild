# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Script and installkernel hook to copy Linux kernel to the host system and update .wslconfig."
HOMEPAGE="https://pypi.org/project/installkernel-wsl/"
SRC_URI="https://github.com/Tatsh/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}
