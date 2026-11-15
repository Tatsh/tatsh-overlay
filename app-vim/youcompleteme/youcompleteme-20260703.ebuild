# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0..5} )
inherit python-single-r1

DESCRIPTION="A code-completion engine for Vim"
HOMEPAGE="https://github.com/ycm-core/YouCompleteMe"
SHA="d4c91430b70a21ce471c8572400b647d313995b4"
MY_PN="YouCompleteMe"
SRC_URI="https://github.com/ycm-core/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${SHA}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="|| ( >=app-editors/vim-7.3[python] >=app-editors/gvim-7.3[python] )"
# shellcheck disable=SC2016
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	llvm-core/clang:=
	$(python_gen_cond_dep 'dev-python/requests-futures[${PYTHON_USEDEP}]' "${PYTHON_COMPAT[@]}")
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]' "${PYTHON_COMPAT[@]}")
	$(python_gen_cond_dep 'dev-util/ycmd[${PYTHON_SINGLE_USEDEP}]' "${PYTHON_COMPAT[@]}")"
# shellcheck disable=SC2016
BDEPEND="test? (
	${RDEPEND}
	$(python_gen_cond_dep '
		dev-python/pyhamcrest[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	')
)"

src_prepare() {
	rm -fR third_party/ || die
	eapply -p0 "${FILESDIR}"
	sed -e "s:@PYTHON_SITE_PACKAGES_DIR@:$(python_get_sitedir):" \
		-i python/ycm/paths.py || die
	default
}

src_test() {
	local EPYTEST_DESELECT=(
		# Need PYTHON_USED_DURING_BUILDING, which ycmd's build.py writes but the
		# ycmd package does not install.
		python/ycm/tests/youcompleteme_test.py::YouCompleteMeTest::test_YouCompleteMe_InvalidPythonInterpreterPath
		python/ycm/tests/youcompleteme_test.py::YouCompleteMeTest::test_YouCompleteMe_NoPythonInterpreterFound
	)
	local -x PYTHONPATH="${S}/python"
	epytest python/ycm/tests
}

src_install() {
	rm -r python/ycm/tests || die
	python_domodule python/ycm
	insinto /usr/share/vim/vimfiles
	doins -r autoload plugin
	dodoc doc/"${PN}".txt
}

pkg_postinst() {
	einfo "For JavaScript and TypeScript completion, run the following as a normal user:"
	einfo ""
	einfo "npm install -g tern typescript"
	einfo ""
	einfo "Then set the following in your vimrc:"
	einfo ""
	einfo "let g:ycm_tsserver_binary_path = '~/.node/bin/tsserver'"
	einfo ""
	einfo "For Go completion, have gopls in your PATH."
	einfo ""
	einfo "For C# completion (not supported), install dev-lang/mono and "
	einfo "Omnisharp and set the path to OmniSharp.exe in your vimrc:"
	einfo ""
	einfo "let g:ycm_roslyn_binary_path = 'path/to/OmniSharp.exe'"
	einfo ""
	einfo "Please be sure to reference the documentation before filing bugs."
	einfo ""
	einfo "https://github.com/ycm-core/YouCompleteMe/blob/master/README.md"
	einfo ""
	einfo "Java and Rust support are not tested with this build."
}
