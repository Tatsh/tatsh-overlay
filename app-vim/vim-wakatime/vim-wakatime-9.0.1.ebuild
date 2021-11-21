# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

DESCRIPTION="vim plugin: automatic time tracking with WakaTime"
HOMEPAGE="https://github.com/wakatime/vim-wakatime"
LICENSE="BSD"
KEYWORDS="~amd64"
SRC_URI="https://github.com/wakatime/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

VIM_PLUGIN_HELPURI="https://github.com/wakatime/vim-wakatime"

src_prepare() {
	rm -fR packages/ || die
	# empty, delete it
	rm -fR doc/ || die
	default
}

pkg_postinst() {
	einfo
	einfo "Be sure to have wakatime-cli in your path for this plugin to work."
	einfo
	einfo "You can get this via the GURU repository: dev-util/wakatime-cli"
	einfo
}
