# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

DESCRIPTION="Kotlin plugin for Vim."
HOMEPAGE="https://github.com/udalov/kotlin-vim"
SHA="53fe045906df8eeb07cb77b078fc93acda6c90b8"
SRC_URI="https://github.com/udalov/kotlin-vim/archive/${SHA}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~ppc64 ~x86"

VIM_PLUGIN_HELPFILES="README.md"
VIM_PLUGIN_HELPURI="https://github.com/udalov/kotlin-vim"
