# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="An async GitLab API library"
HOMEPAGE="
	https://gitlab.com/beenje/gidgetlab
	https://pypi.org/project/gidgetlab/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-python/setuptools-scm-8.0[${PYTHON_USEDEP}]"
