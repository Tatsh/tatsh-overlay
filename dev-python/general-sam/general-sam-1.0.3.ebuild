# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=maturin

CRATES="
	autocfg-1.5.0
	cc-1.2.36
	cfg-if-1.0.3
	either-1.15.0
	find-msvc-tools-0.1.1
	general-sam-1.0.3
	getrandom-0.3.3
	heck-0.5.0
	indoc-2.0.6
	libc-0.2.175
	memoffset-0.9.1
	once_cell-1.21.3
	portable-atomic-1.11.1
	ppv-lite86-0.2.21
	proc-macro2-1.0.101
	pyo3-0.26.0
	pyo3-build-config-0.26.0
	pyo3-ffi-0.26.0
	pyo3-macros-0.26.0
	pyo3-macros-backend-0.26.0
	python3-dll-a-0.2.14
	quote-1.0.40
	rand-0.9.2
	rand_chacha-0.9.0
	rand_core-0.9.3
	r-efi-5.3.0
	shlex-1.3.0
	syn-2.0.106
	target-lexicon-0.13.2
	unicode-ident-1.0.18
	unindent-0.2.4
	wasi-0.14.4+wasi-0.2.4
	wit-bindgen-0.45.1
	zerocopy-0.8.27
	zerocopy-derive-0.8.27
"

inherit cargo distutils-r1 pypi

DESCRIPTION="General Suffix Automaton implementation in Python."
HOMEPAGE="https://github.com/ModelTC/general-sam-py"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
