# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

DESCRIPTION="Vim plugin: reduce Portage atoms to category/package, keeping USE flags"
HOMEPAGE="https://github.com/Tatsh/vim-reduce-atoms"
SRC_URI="https://github.com/Tatsh/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

# qatom does the atom parsing.
RDEPEND="app-portage/portage-utils"

DOCS=( README.md )
VIM_PLUGIN_HELPURI="https://github.com/Tatsh/vim-reduce-atoms"
