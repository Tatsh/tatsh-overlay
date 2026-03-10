# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="aho-corasick@1.1.3
	anstream@0.6.20
	anstyle-parse@0.2.7
	anstyle-query@1.1.4
	anstyle-wincon@3.0.10
	anstyle@1.0.11
	autocfg@1.5.0
	cfg-if@1.0.3
	clap@4.5.46
	clap_builder@4.5.46
	clap_derive@4.5.45
	clap_lex@0.7.5
	colorchoice@1.0.4
	crc32fast@1.5.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-timer@3.0.3
	futures-util@0.3.31
	futures@0.3.31
	glob@0.3.3
	heck@0.5.0
	indoc@2.0.6
	is_terminal_polyfill@1.70.1
	libc@0.2.175
	memchr@2.7.5
	memoffset@0.9.1
	once_cell@1.21.3
	once_cell_polyfill@1.70.1
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	portable-atomic@1.11.1
	proc-macro2@1.0.101
	pyo3-build-config@0.26.0
	pyo3-ffi@0.26.0
	pyo3-macros-backend@0.26.0
	pyo3-macros@0.26.0
	pyo3@0.26.0
	quote@1.0.40
	regex-automata@0.4.10
	regex-syntax@0.8.6
	regex@1.11.2
	relative-path@1.9.3
	rstest@0.18.2
	rstest_macros@0.18.2
	rustc_version@0.4.1
	semver@1.0.26
	slab@0.4.11
	strsim@0.11.1
	syn@2.0.106
	target-lexicon@0.13.3
	thiserror-impl@2.0.17
	thiserror@2.0.17
	unicode-ident@1.0.18
	unindent@0.2.4
	utf8parse@0.2.2
	windows-link@0.1.3
	windows-sys@0.60.2
	windows-targets@0.53.3
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.53.0"
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_1{1,2,3,4} )
inherit cargo distutils-r1

DESCRIPTION="Common N64 compression formats implemented in Rust (library only)."
HOMEPAGE="https://pypi.org/project/crunch64/"
SRC_URI="https://github.com/decompals/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${P}/lib"
