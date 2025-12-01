# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{10..14} )
RUST_MIN_VER="1.80"
CRATES="
	aho-corasick@1.1.4
	array-init@2.1.0
	atty@0.2.14
	autocfg@1.5.0
	bitflags@1.3.2
	bstr@0.2.17
	bstr@1.12.1
	bumpalo@3.19.0
	cast@0.3.0
	cfg-if@1.0.4
	clap@2.34.0
	cqdb@0.5.8
	crfs@0.1.3
	criterion-plot@0.4.5
	criterion@0.3.6
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	csv-core@0.1.13
	csv@1.4.0
	either@1.15.0
	half@1.8.3
	heck@0.5.0
	hermit-abi@0.1.19
	indoc@2.0.7
	itertools@0.10.5
	itoa@1.0.15
	jhash@0.1.1
	js-sys@0.3.83
	lazy_static@1.5.0
	libc@0.2.177
	memchr@2.7.6
	memoffset@0.9.1
	num-traits@0.2.19
	once_cell@1.21.3
	oorandom@11.1.5
	plotters-backend@0.3.7
	plotters-svg@0.3.7
	plotters@0.3.7
	portable-atomic@1.11.1
	proc-macro2@1.0.103
	pyo3-build-config@0.25.1
	pyo3-ffi@0.25.1
	pyo3-macros-backend@0.25.1
	pyo3-macros@0.25.1
	pyo3@0.25.1
	quote@1.0.42
	rayon-core@1.13.0
	rayon@1.11.0
	regex-automata@0.1.10
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	rustversion@1.0.22
	ryu@1.0.20
	same-file@1.0.6
	serde@1.0.228
	serde_cbor@0.11.2
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.145
	syn@2.0.111
	target-lexicon@0.13.3
	textwrap@0.11.0
	tinytemplate@1.2.1
	unicode-ident@1.0.22
	unicode-width@0.1.14
	unindent@0.2.4
	walkdir@2.5.0
	wasm-bindgen-macro-support@0.2.106
	wasm-bindgen-macro@0.2.106
	wasm-bindgen-shared@0.2.106
	wasm-bindgen@0.2.106
	web-sys@0.3.83
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.61.2
"

inherit cargo distutils-r1

DESCRIPTION="Underthesea Core."
HOMEPAGE="https://github.com/undertheseanlp/underthesea https://pypi.org/project/underthesea-core/"
UNDERTHESEA_PV="8.3.0"
SRC_URI="https://github.com/undertheseanlp/underthesea/archive/v${UNDERTHESEA_PV}.tar.gz -> underthesea-${UNDERTHESEA_PV}.tar.gz
	${CARGO_CRATE_URIS}"
S="${WORKDIR}/underthesea-${UNDERTHESEA_PV}/extensions/underthesea_core"

LICENSE="GPL-3 Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-3.0
	|| ( Apache-2.0 Boost-1.0 )"
SLOT="0"
KEYWORDS="~amd64"
