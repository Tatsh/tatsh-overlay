# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Asynchronous WebDAV server implementation with multiple providers"
HOMEPAGE="https://github.com/rexzhang/asgi-webdav https://pypi.org/project/asgiwebdav/"
# The sdist leaves out test support files and data.
SRC_URI="https://github.com/rexzhang/asgi-webdav/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/asgi-webdav-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/aiofiles-25.1.0[${PYTHON_USEDEP}]
	>=dev-python/asgimiddlewarestaticfile-0.7.0[${PYTHON_USEDEP}]
	dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/dataclass-wizard-1.0.0[${PYTHON_USEDEP}]
	<dev-python/dataclass-wizard-1.1[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1[${PYTHON_USEDEP}]
	<dev-python/python-dotenv-2[${PYTHON_USEDEP}]
	>=dev-python/xmltodict-1.0.2[${PYTHON_USEDEP}]
	<dev-python/xmltodict-1.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/icecream[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	sed -i -e 's/"--cov.*/""/' pyproject.toml || die
	distutils-r1_src_prepare
}

EPYTEST_IGNORE=(
	# Need sentry-sdk and httpx-kerberos.
	tests/test_provider_webhdfs.py
	tests/test_server.py
	# Manual tests; upstream addopts ignore them.
	tests/by_hand
)

src_test() {
	# Root ignores the read-only directory this expects a 403 from.
	if [[ ${EUID} -eq 0 ]]; then
		EPYTEST_DESELECT+=(
			"tests/test_webdav_method.py::test_method_put_fs_defensive_error_paths[fs]"
		)
	fi
	distutils-r1_src_test
}

EPYTEST_PLUGINS=( pytest-{asyncio,mock} )
distutils_enable_tests pytest
