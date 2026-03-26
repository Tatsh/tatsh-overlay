# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{2,3,4} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Front-end to metaflac to set common FLAC tags."
HOMEPAGE="https://github.com/Tatsh/flacted"
S="${WORKDIR}/${PN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/bascom[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	app-misc/deltona[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	media-libs/flac"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}

distutils_enable_tests pytest
