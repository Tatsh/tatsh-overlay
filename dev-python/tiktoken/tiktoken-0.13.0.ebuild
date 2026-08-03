# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

CRATES="
	aho-corasick@1.1.4
	bit-set@0.8.0
	bit-vec@0.8.0
	bstr@1.13.0
	fancy-regex@0.17.0
	heck@0.5.0
	libc@0.2.189
	memchr@2.8.3
	once_cell@1.21.4
	portable-atomic@1.14.0
	proc-macro2@1.0.107
	pyo3@0.28.3
	pyo3-build-config@0.28.3
	pyo3-ffi@0.28.3
	pyo3-macros@0.28.3
	pyo3-macros-backend@0.28.3
	quote@1.0.47
	regex@1.13.1
	regex-automata@0.4.16
	regex-syntax@0.8.11
	rustc-hash@2.1.3
	serde_core@1.0.229
	serde_derive@1.0.229
	syn@2.0.119
	syn@3.0.3
	target-lexicon@0.13.5
	unicode-ident@1.0.24
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Fast BPE tokeniser for use with OpenAI's models."
HOMEPAGE="https://github.com/openai/tiktoken"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
LICENSE+=" Apache-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/regex-2022.1.18[${PYTHON_USEDEP}]
	>=dev-python/requests-2.26.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
