# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Host-side of the extension to open any link or page URL in mpv via browser context menu."
HOMEPAGE="
	https://github.com/Tatsh/open-in-mpv
	https://pypi.org/project/open-in-mpv/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	media-video/mpv
	net-misc/yt-dlp"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

src_prepare() {
	# Drop the open-in-mpv-install entry point — system-wide installation of
	# the native-messaging-host JSON is handled by src_install below; users
	# shouldn't have a script in PATH that writes to /etc.
	sed -i -e '/open-in-mpv-install/d' pyproject.toml || die
	default
}

src_install() {
	distutils-r1_src_install
	cat > sh.tat.open_in_mpv.json <<-EOF || die
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
	insinto /etc/opt/chrome/native-messaging-hosts
	doins sh.tat.open_in_mpv.json
	insinto /etc/chromium/native-messaging-hosts
	doins sh.tat.open_in_mpv.json
	doman "man/${PN}.1"
}

distutils_enable_tests pytest
