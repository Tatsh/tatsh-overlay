# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Minimal, Chocately-compatible NuGet server in a Django app."
HOMEPAGE="https://github.com/Tatsh/minchoc"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/django-stubs-ext[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]"
