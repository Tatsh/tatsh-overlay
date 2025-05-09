# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2} )
inherit distutils-r1

DESCRIPTION="Host-side script for the Open in mpv Chrome extension."
HOMEPAGE="https://github.com/Tatsh/open-in-mpv"
SRC_URI="https://github.com/Tatsh/open-in-mpv/archive/v${PV}.tar.gz -> ${P}.tar.gz"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="${PYTHON_DEPS}
	dev-python/loguru[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	media-video/mpv
	net-misc/yt-dlp"

src_prepare() {
	sed -re '/open-in-mpv-(un)?install/d' -i pyproject.toml || die
	cat << EOF > sh.tat.open_in_mpv.json
{
  "name": "sh.tat.open_in_mpv",
  "description": "Opens a URL in mpv (for use with extension).",
  "path": "${EPREFIX}/usr/bin/open-in-mpv",
  "type": "stdio",
  "allowed_origins": [
    "chrome-extension://jlhcojdohadhkchjpjefbmagpiaedpgc/"
  ]
}
EOF
	default
}

src_install() {
	distutils-r1_src_install
	insinto /etc/opt/chrome/native-messaging-hosts
	doins sh.tat.open_in_mpv.json
	insinto /etc/chromium/native-messaging-hosts
	doins sh.tat.open_in_mpv.json
	einstalldocs
}
