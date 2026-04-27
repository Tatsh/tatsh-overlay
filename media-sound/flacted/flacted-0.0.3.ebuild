# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Front-end to metaflac to set common FLAC tags."
HOMEPAGE="
	https://github.com/Tatsh/flacted
	https://pypi.org/project/flacted/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-misc/deltona-0.1.4[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	media-libs/flac"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}
