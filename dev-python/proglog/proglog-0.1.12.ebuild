# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )

inherit distutils-r1

DESCRIPTION="Progress logging system for Python."
HOMEPAGE="https://pypi.org/project/proglog/"
SRC_URI="https://github.com/Edinburgh-Genome-Foundry/${PN^}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/tqdm[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN^}-${PV}"

distutils_enable_tests pytest

src_prepare() {
	sed -re 's/exclude =.*/exclude = ["docs", "examples", "tests"]/g' -i pyproject.toml || die
	distutils-r1_src_prepare
}
