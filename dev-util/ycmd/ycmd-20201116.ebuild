# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )
inherit cmake python-single-r1

DESCRIPTION="A code-completion & code-comprehension server."
HOMEPAGE="https://github.com/ycm-core/ycmd"
CORE_VERSION=44
MY_SHA="3aa00aea0e26c98091f53583bff833796bf8fc41"
SRC_URI="https://github.com/ycm-core/ycmd/archive/3aa00aea0e26c98091f53583bff833796bf8fc41.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PYTHON_MINOR_VERSION=8
RDEPEND="
	$(python_gen_cond_dep 'dev-python/bottle[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/jedi[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/regex[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/waitress[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/watchdog[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	|| ( sys-devel/clang:11 sys-devel/clang:10 )
"

S="${WORKDIR}/${PN}-${MY_SHA}/cpp"

src_prepare() {
	rm -fR ../ycmd/tests ../third_party
	eapply --directory="${WORKDIR}/${PN}-${MY_SHA}" -p0 "${FILESDIR}"
	sed -e "s/@CORE_VERSION@/${CORE_VERSION}/" \
		-e "s|@LIBCLANG_DIR@|$(llvm-config --libdir)|" \
		-i ../ycmd/utils.py
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_CLANG_COMPLETER=ON
		-DUSE_SYSTEM_LIBCLANG=ON
		-DPYTHON_LIBRARY=${EPREFIX}/usr/$(get_libdir)/libpython3.${PYTHON_MINOR_VERSION}.so
		-DPYTHON_INCLUDE_DIR=${EPREFIX}/usr/include/python3.${PYTHON_MINOR_VERSION}
	)
	cmake_src_configure
}

src_install() {
	into "$(python_get_sitedir)"
	cp ../ycm_core.so "${D}/$(python_get_sitedir)"
	python_domodule ../ycmd
}
