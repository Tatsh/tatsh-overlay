# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="HTTP 1.1, 2, and 3 client with both sync and async interfaces"
HOMEPAGE="
	https://github.com/jawah/urllib3.future
	https://pypi.org/project/urllib3-future/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/h11-0.11.0[${PYTHON_USEDEP}]
	<dev-python/h11-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/jh2-5.0.3[${PYTHON_USEDEP}]
	<dev-python/jh2-6.0.0[${PYTHON_USEDEP}]"
# qh3 disabled: ls-qpack-rs-sys 0.3.0 fails with newer glibc
#RDEPEND+=" >=dev-python/qh3-1.5.4[${PYTHON_USEDEP}]
#	<dev-python/qh3-2.0.0[${PYTHON_USEDEP}]"

src_prepare() {
	sed -re 's/^SHOULD_PREVENT_FORK_OVERRIDE =.*/SHOULD_PREVENT_FORK_OVERRIDE = 1/' \
		-i hatch_build.py || die
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
