# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/doronz88/pymobiledevice3
# Python 3.12 needs sslpsk-pmd3, which is not packaged.
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pure Python 3 implementation for working with iDevices"
HOMEPAGE="https://github.com/doronz88/pymobiledevice3 https://pypi.org/project/pymobiledevice3/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="
	>=dev-python/ansilogs-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/asgiwebdav-2.0.1[${PYTHON_USEDEP}]
	dev-python/asn1[${PYTHON_USEDEP}]
	>=dev-python/av-14.0.0[${PYTHON_USEDEP}]
	>=dev-python/bpylist2-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/bytestruct-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-43.0.0[${PYTHON_USEDEP}]
	dev-python/daemonize[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	>=dev-python/developer-disk-image-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.93.0[${PYTHON_USEDEP}]
	dev-python/hyperframe[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	>=dev-python/ipsw-parser-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/opack2-0.2.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pmd-net-addr[${PYTHON_USEDEP}]
	>=dev-python/pmd-pytcp-0.3.9[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/pycrashreport-2.0.0[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	>=dev-python/pygnuutils-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/pyimg4-0.8.8[${PYTHON_USEDEP}]
	>=dev-python/pyiosbackup-0.2.4[${PYTHON_USEDEP}]
	>=dev-python/pykdebugparser-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/python-pcapng-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/pytun-pmd3-3.0.3[${PYTHON_USEDEP}]
	>=dev-python/qh3-1.0.0[${PYTHON_USEDEP}]
	<dev-python/qh3-2[${PYTHON_USEDEP}]
	>=dev-python/questionary-2.0.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/rich-13.0.0[${PYTHON_USEDEP}]
	>=dev-python/typer-0.25[${PYTHON_USEDEP}]
	>=dev-python/typer-injector-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.15.0[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/backports-zstd[${PYTHON_USEDEP}]
	' python3_13)
"
BDEPEND="
	test? (
		dev-python/httpx[${PYTHON_USEDEP}]
	)
"

src_test() {
	# Tests marked device need an iPhone over usbmuxd.
	local -x PYTEST_ADDOPTS="-m 'not device'"
	distutils-r1_src_test
}

# tests/test_socket_hygiene.py reruns pytest in a subprocess, which needs
# pytest-asyncio too.
EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
