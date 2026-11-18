# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="ASGI middleware for serving static files"
HOMEPAGE="https://github.com/rexzhang/asgi-middleware-static-file https://pypi.org/project/asgimiddlewarestaticfile/"
# The sdist leaves out test support files and data.
SRC_URI="https://github.com/rexzhang/asgi-middleware-static-file/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/asgi-middleware-static-file-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/aiofiles-25.1.0[${PYTHON_USEDEP}]
	dev-python/asgiref[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i -e 's/"--cov.*/""/' pyproject.toml || die
	distutils-r1_src_prepare
}

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
