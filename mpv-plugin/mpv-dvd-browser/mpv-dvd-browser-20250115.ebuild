# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MPV_REQ_USE="lua"
USE_MPV="rdepend"
inherit mpv-plugin

DESCRIPTION="API to allow scripts to create interactive scrollable lists in mpv player."
HOMEPAGE="https://github.com/CogentRedTester/mpv-dvd-browser"
SHA="9d4d55b086eb1d4a92c6684060fe526ebee53630"
SRC_URI="https://github.com/CogentRedTester/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
RDEPEND="media-video/lsdvd mpv-plugin/mpv-scroll-list"

MPV_PLUGIN_FILES=(
	"${PN:4}.lua"
)

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	mpv-plugin_src_install
	insinto /etc/mpv/script-opts
	doins dvd_browser.conf
}
