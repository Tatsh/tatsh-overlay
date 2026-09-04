# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_1{0..5} )
RUST_MIN_VER="1.85.0"

CRATES="
	bitflags@1.3.2
	daachorse@3.0.3
	fastrand@2.5.0
	heck@0.5.0
	libc@0.2.189
	once_cell@1.21.4
	phf@0.13.1
	phf_generator@0.13.1
	phf_macros@0.13.1
	phf_shared@0.13.1
	portable-atomic@1.15.0
	proc-macro2@1.0.107
	pyo3@0.29.2
	pyo3-build-config@0.29.2
	pyo3-ffi@0.29.2
	pyo3-macros@0.29.2
	pyo3-macros-backend@0.29.2
	quote@1.0.47
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	siphasher@1.0.3
	syn@2.0.119
	syn@3.0.3
	target-lexicon@0.13.5
	text2num@2.8.0
	unicode-ident@1.0.24
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Parse and convert number wording into digit representation."
HOMEPAGE="https://pypi.org/project/text2num/"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
