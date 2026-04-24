# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for the GitLab REST and GraphQL APIs"
HOMEPAGE="
	https://python-gitlab.readthedocs.io
	https://github.com/python-gitlab/python-gitlab
	https://pypi.org/project/python-gitlab/
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/requests-2.32.0[${PYTHON_USEDEP}]
	>=dev-python/requests-toolbelt-1.0.0[${PYTHON_USEDEP}]"
