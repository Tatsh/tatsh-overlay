# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Colorful Python TAB completer"
HOMEPAGE="
	https://github.com/bretello/fancycompleter
	https://pypi.org/project/fancycompleter/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="$(python_gen_cond_dep '>=dev-python/pyrepl-0.11.3[${PYTHON_USEDEP}]' python3_{10,11,12})"

distutils_enable_tests pytest
