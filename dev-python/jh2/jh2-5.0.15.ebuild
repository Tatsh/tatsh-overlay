# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYPI_VERIFY_REPO=https://github.com/jawah/h2
PYTHON_COMPAT=( python3_{11..15} )
RUST_MIN_VER="1.83.0"

CRATES="
	cc@1.4.7
	find-msvc-tools@0.1.13
	heck@0.5.0
	httlib-hpack@0.1.3
	httlib-huffman@0.3.4
	libc@0.2.189
	once_cell@1.21.4
	portable-atomic@1.15.0
	proc-macro2@1.0.107
	pyo3-build-config@0.28.3
	pyo3-ffi@0.28.3
	pyo3-macros-backend@0.28.3
	pyo3-macros@0.28.3
	pyo3@0.28.3
	python3-dll-a@0.2.15
	quote@1.0.47
	shlex@2.0.1
	syn@2.0.119
	target-lexicon@0.13.5
	unicode-ident@1.0.26
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
# Dependent crate licenses
LICENSE+=" Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/jh2/_hazmat.*.so"

src_unpack() {
	# pypi exports src_unpack (provenance check), overriding cargo's vendoring.
	pypi_src_unpack
	cargo_crate_unpack
	cargo_gen_config
}

src_test() {
	# Import the built extension rather than the source-tree jh2/.
	rm -r jh2 || die
	distutils-r1_src_test
}

EPYTEST_PLUGINS=( hypothesis )
distutils_enable_tests pytest
