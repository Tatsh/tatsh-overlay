# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

CRATES="
	aho-corasick@1.1.3
	autocfg@1.5.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bstr@1.12.0
	fancy-regex@0.13.0
	heck@0.5.0
	indoc@2.0.6
	libc@0.2.177
	memchr@2.7.6
	memoffset@0.9.1
	once_cell@1.21.3
	portable-atomic@1.11.1
	proc-macro2@1.0.101
	pyo3@0.26.0
	pyo3-build-config@0.26.0
	pyo3-ffi@0.26.0
	pyo3-macros@0.26.0
	pyo3-macros-backend@0.26.0
	quote@1.0.41
	regex@1.12.2
	regex-automata@0.4.13
	regex-syntax@0.8.8
	rustc-hash@2.1.1
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	syn@2.0.107
	target-lexicon@0.13.3
	unicode-ident@1.0.19
	unindent@0.2.4
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
