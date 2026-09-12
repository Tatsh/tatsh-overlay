# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1

MY_COMMIT="1dc5fa90311992c92b7cff08f3c5354ece67a995"

DESCRIPTION="Reverse engineering framework for machine code manipulation."
HOMEPAGE="https://github.com/cea-sec/miasm https://pypi.org/project/miasm/"
# Upstream has not tagged since 0.1.5 in 2020. That release's setup.py imports
# distutils, which Python 3.12 removed, while master builds with setuptools
# alone and has since been fixed for the Python 3.14 ast changes.
SRC_URI="https://github.com/cea-sec/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cparser graph llvm"

RDEPEND="
	>=dev-python/pyparsing-2.4.1[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	cparser? ( >=dev-python/pycparser-2.17[${PYTHON_USEDEP}] )
	graph? ( dev-python/graphviz[${PYTHON_USEDEP}] )
	llvm? ( dev-python/llvmlite[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( dev-python/parameterized[${PYTHON_USEDEP}] )"

EPYTEST_IGNORE=(
	# Helper modules for test_all.py rather than test modules: they read
	# sys.argv at import time and abort when pytest collects them.
	test/arch/aarch64/unit/asm_test.py
	test/arch/mips32/unit/asm_test.py
	test/arch/x86/unit/asm_test.py
	test/os_dep/linux/test_env.py
	# test_all.py is a subprocess driver that reruns everything below it.
	test/test_all.py
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
