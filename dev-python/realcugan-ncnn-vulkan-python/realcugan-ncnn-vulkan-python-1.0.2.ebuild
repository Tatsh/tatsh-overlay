# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1 pypi

DESCRIPTION="A Python FFI of nihui/realcugan-ncnn-vulkan achieved with SWIG."
HOMEPAGE="https://pypi.org/project/realcugan-ncnn-vulkan-python/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/cmake-build-extension[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P}"

distutils_enable_tests pytest
