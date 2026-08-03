# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_USE_PEP517=maturin

CRATES="
	cfg-if@1.0.4
	chacha20@0.10.1
	cpufeatures@0.3.0
	either@1.16.0
	general-sam@1.0.5
	getrandom@0.4.3
	heck@0.5.0
	libc@0.2.188
	once_cell@1.21.4
	portable-atomic@1.14.0
	proc-macro2@1.0.107
	pyo3@0.29.0
	pyo3-build-config@0.29.0
	pyo3-ffi@0.29.0
	pyo3-macros@0.29.0
	pyo3-macros-backend@0.29.0
	quote@1.0.47
	r-efi@6.0.0
	rand@0.10.2
	rand_core@0.10.1
	syn@2.0.119
	target-lexicon@0.13.5
	unicode-ident@1.0.24
"

inherit cargo distutils-r1 pypi

DESCRIPTION="General Suffix Automaton implementation in Python."
HOMEPAGE="https://github.com/ModelTC/general-sam-py"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
