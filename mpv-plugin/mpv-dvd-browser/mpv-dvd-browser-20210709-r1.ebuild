# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
inherit mpv-plugin

DESCRIPTION="API to allow scripts to create interactive scrollable lists in mpv player."
HOMEPAGE="https://github.com/CogentRedTester/mpv-dvd-browser"
SHA="114417bbfa1fc6dd17162fa84cd1c0e5d78cc0dd"
SRC_URI="https://github.com/CogentRedTester/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="media-video/lsdvd mpv-plugin/mpv-scroll-list"

MPV_PLUGIN_FILES=(
	${PN:4}.lua
)

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	mpv-plugin_src_install
	insinto /usr/$(get_libdir)/mpv
	doins dvd_browser.conf
	if use autoload; then
		keepdir /etc/mpv/script-opts
		dosym ../../../usr/$(get_libdir)/mpv/dvd_browser.conf /etc/mpv/script-opts/dvd_browser.conf
	fi
}
