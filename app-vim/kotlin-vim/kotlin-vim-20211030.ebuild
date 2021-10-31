# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="Kotlin plugin for Vim."
HOMEPAGE="https://github.com/udalov/kotlin-vim"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"

SHA="d8e5ccc2f208555edc86b522610f14078e4eb951"
SRC_URI="https://github.com/udalov/kotlin-vim/archive/${SHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${SHA}"

VIM_PLUGIN_HELPFILES="README.md"
VIM_PLUGIN_HELPURI="https://github.com/udalov/kotlin-vim"
