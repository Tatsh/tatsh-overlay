# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_1{0..4} )

CRATES="autocfg@1.4.0
	bitflags@1.3.2
	cfg-if@1.0.0
	daachorse@1.0.0
	getrandom@0.1.16
	heck@0.5.0
	indoc@2.0.6
	libc@0.2.172
	memoffset@0.9.1
	once_cell@1.21.3
	phf@0.8.0
	phf_generator@0.8.0
	phf_macros@0.8.0
	phf_shared@0.8.0
	portable-atomic@1.11.0
	ppv-lite86@0.2.21
	proc-macro-hack@0.5.20+deprecated
	proc-macro2@1.0.95
	pyo3-build-config@0.24.2
	pyo3-ffi@0.24.2
	pyo3-macros-backend@0.24.2
	pyo3-macros@0.24.2
	pyo3@0.24.2
	quote@1.0.40
	rand@0.7.3
	rand_chacha@0.2.2
	rand_core@0.5.1
	rand_hc@0.2.0
	rand_pcg@0.2.1
	siphasher@0.3.11
	syn@1.0.109
	syn@2.0.101
	target-lexicon@0.13.2
	text2num@2.6.2
	unicode-ident@1.0.18
	unindent@0.2.4
	wasi@0.9.0+wasi-snapshot-preview1
	zerocopy-derive@0.8.25
	zerocopy@0.8.25"

inherit cargo distutils-r1 pypi

DESCRIPTION="Parse and convert number wording into digit representation."
HOMEPAGE="https://pypi.org/project/text2num/"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
