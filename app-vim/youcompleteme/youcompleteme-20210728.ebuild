# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit python-single-r1

DESCRIPTION="A code-completion engine for Vim."
HOMEPAGE="https://github.com/ycm-core/YouCompleteMe"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"

SLOT="0"
MY_SHA="8c6081c79b2250467c45f475332e3a3a33028467"
MY_PN="YouCompleteMe"
SRC_URI="https://github.com/ycm-core/${MY_PN}/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

DEPEND="|| ( >=app-editors/vim-7.3 >=app-editors/gvim-7.3 )"
RDEPEND="${DEPEND}
	|| ( sys-devel/clang:10 sys-devel/clang:11 sys-devel/clang:12 )
	$(python_gen_cond_dep 'dev-python/requests-futures[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]' ${PYTHON_COMPAT[*]})
	$(python_gen_cond_dep 'dev-util/ycmd[${PYTHON_SINGLE_USEDEP}]' ${PYTHON_COMPAT[*]})"

S="${WORKDIR}/${MY_PN}-${MY_SHA}"

src_prepare() {
	rm -fR third_party/ python/ycm/tests/
	eapply -p0 "${FILESDIR}"
	sed -e "s:@PYTHON_SITE_PACKAGES_DIR@:$(python_get_sitedir):" \
		-i python/ycm/paths.py || die
	default
}

src_install() {
	python_domodule python/ycm
	insinto /usr/share/vim/vimfiles
	doins -r autoload plugin
	dodoc doc/${PN}.txt
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
