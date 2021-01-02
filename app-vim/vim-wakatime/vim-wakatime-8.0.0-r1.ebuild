# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

DESCRIPTION="vim plugin: automatic time tracking with WakaTime"
HOMEPAGE="https://github.com/wakatime/vim-wakatime"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="https://github.com/wakatime/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

RDEPEND="${DEPEND} app-misc/wakatime"

VIM_PLUGIN_HELPURI="https://github.com/wakatime/vim-wakatime"

PATCHES=(
	"${FILESDIR}/${PN}-fix-cli-path.patch"
	"${FILESDIR}/${PN}-fix-overridecommandprefix.patch"
)

src_prepare() {
	rm -fR packages/
	# empty, delete it
	rm -fR doc/
	default
}
