# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8..10} )
inherit cmake python-single-r1

DESCRIPTION="A code-completion & code-comprehension server."
HOMEPAGE="https://github.com/ycm-core/ycmd"
CORE_VERSION=45
SHA="d8cdcadbf3de999fba6604149f555a0fc769a424"
SRC_URI="https://github.com/ycm-core/ycmd/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-cpp/abseil-cpp"
RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep 'dev-python/bottle[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/jedi[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/regex[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/waitress[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/watchdog[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	|| ( sys-devel/clang:11[static-analyzer]
		sys-devel/clang:13[static-analyzer]
		sys-devel/clang:12[static-analyzer] )
	|| ( sys-libs/compiler-rt:11.1.0
		sys-libs/compiler-rt:13.0.0
		sys-libs/compiler-rt:12.0.1 )"

S="${WORKDIR}/${PN}-${SHA}/cpp"

src_prepare() {
	rm -fR ../ycmd/tests ../third_party
	eapply --directory="${WORKDIR}/${PN}-${SHA}" -p0 "${FILESDIR}"
	sed -e "s/@CORE_VERSION@/${CORE_VERSION}/" \
		-e "s|@LIBCLANG_DIR@|$(llvm-config --libdir)|" \
		-e "s:CLANG_RESOURCE_DIR =.*:CLANG_RESOURCE_DIR = '$(find "${EPREFIX}/usr/lib/clang" -mindepth 1 -maxdepth 1 -type d | head -n 1)':" \
		-i ../ycmd/utils.py || die
	local -r clang_version=$(best_version sys-devel/clang)
	sed -e "s/@EPREFIX@/${EPREFIX}/g" \
		-e "s/@CLANG_VERSION@/${clang_version:16:2}/" -i \
		../ycmd/completers/cpp/clangd_completer.py || die
	sed -r \
		-e "s|Python3 [0-9\\.]+ REQUIRED COMPONENTS|Python3 3.$(ver_cut 2 "${EPYTHON:6}") EXACT REQUIRED COMPONENTS|" \
		-i CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_CLANG_TIDY=ON
		-DUSE_SYSTEM_ABSEIL=ON
	)
	cmake_src_configure
}

src_install() {
	into "$(python_get_sitedir)"
	cp ../ycm_core.cpython*.so "${D}/$(python_get_sitedir)"
	python_domodule ../ycmd
}
