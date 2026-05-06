# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{11..14} )

CRATES="
	cc@1.2.59
	find-msvc-tools@0.1.9
	heck@0.5.0
	httlib-hpack@0.1.3
	httlib-huffman@0.3.4
	libc@0.2.184
	once_cell@1.21.4
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3@0.28.3
	pyo3-build-config@0.28.3
	pyo3-ffi@0.28.3
	pyo3-macros@0.28.3
	pyo3-macros-backend@0.28.3
	python3-dll-a@0.2.14
	quote@1.0.45
	shlex@1.3.0
	syn@2.0.117
	target-lexicon@0.13.5
	unicode-ident@1.0.24
"

inherit cargo distutils-r1 pypi

DESCRIPTION="HTTP/2 State-Machine based protocol implementation"
HOMEPAGE="
	https://github.com/jawah/h2
	https://pypi.org/project/jh2/
"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
LICENSE+=" Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/jh2/_hazmat.*.so"

src_unpack() {
	cargo_src_unpack
	default
}

distutils_enable_tests pytest
