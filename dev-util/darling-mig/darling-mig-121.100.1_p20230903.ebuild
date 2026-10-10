# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {17..23} )

inherit cmake llvm-r2

# migcom includes Mach headers through Darling's SDK symlinks, which point into the xnu and
# libpthread submodules, so build inside a minimal Darling tree.
DARLING_SHA="60ba801decee7a00782f74f6be4c8ffb013f79ff"
LIBPTHREAD_SHA="f07f265bfbcf071c1adfc808de971e053ea5edc5"
SHA="0f300a7a04bb1174a3b7db58b57d738aadc14e13"
XNU_SHA="fa29287aa2f0115271e091f1031f53c9e024005d"
DESCRIPTION="Apple's Mach Interface Generator (MIG) as used to build Darling."
HOMEPAGE="https://github.com/darlinghq/darling-bootstrap_cmds https://www.darlinghq.org/"
SRC_URI="https://github.com/darlinghq/darling-bootstrap_cmds/archive/${SHA}.tar.gz -> darling-bootstrap_cmds-${SHA}.tar.gz
	https://github.com/darlinghq/darling/archive/${DARLING_SHA}.tar.gz -> darling-${DARLING_SHA}.tar.gz
	https://github.com/darlinghq/darling-libpthread/archive/${LIBPTHREAD_SHA}.tar.gz -> darling-libpthread-${LIBPTHREAD_SHA}.tar.gz
	https://github.com/darlinghq/darling-xnu/archive/${XNU_SHA}.tar.gz -> darling-xnu-${XNU_SHA}.tar.gz"
S="${WORKDIR}/darling-${DARLING_SHA}/src/external/bootstrap_cmds"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="llvm-core/clang"
# shellcheck disable=SC2016
BDEPEND="
	app-alternatives/lex
	app-alternatives/yacc
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}')
"

PATCHES=( "${FILESDIR}/${PN}-0001-Support-standalone-builds-and-installation-as-darlin.patch" )

src_unpack() {
	local top="${WORKDIR}/darling-${DARLING_SHA}" name sha
	unpack "darling-${DARLING_SHA}.tar.gz"
	for name in bootstrap_cmds libpthread xnu; do
		case "${name}" in
			bootstrap_cmds) sha="${SHA}" ;;
			libpthread) sha="${LIBPTHREAD_SHA}" ;;
			xnu) sha="${XNU_SHA}" ;;
		esac
		unpack "darling-${name}-${sha}.tar.gz"
		rmdir "${top}/src/external/${name}" || die
		mv "darling-${name}-${sha}" "${top}/src/external/${name}" || die
	done
}

src_configure() {
	# Apple's headers use clang-only syntax
	llvm_prepend_path "${LLVM_SLOT}"
	local -x CC="${CHOST}-clang" CXX="${CHOST}-clang++"
	local mycmakeargs=( -DDARLING_BASIC_HEADERS="${WORKDIR}/darling-${DARLING_SHA}/basic-headers" )
	cmake_src_configure
}
