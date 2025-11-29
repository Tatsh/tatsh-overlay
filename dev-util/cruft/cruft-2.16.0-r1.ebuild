# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{1,2,3} )

inherit distutils-r1

DESCRIPTION="Fight back against the boilerplate monster."
HOMEPAGE="https://pypi.org/project/cruft/ https://cruft.github.io/ https://github.com/cruft/cruft/"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/gitpython[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/typer[${PYTHON_USEDEP}]
	dev-util/cookiecutter[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-repeat[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)"

PATCHES=(
	"${FILESDIR}/${PN}-0001-generate-remove-filtering-_-.patch"
	"${FILESDIR}/${PN}-0002-improve-get_skip_paths.patch"
	"${FILESDIR}/${PN}-0003-add-include-deleted-files-ex.patch"
)

distutils_enable_tests pytest

src_prepare() {
	sed -re "s/^version =.*/version = \"${PV}\"/" -i pyproject.toml || die
	distutils-r1_src_prepare
}
