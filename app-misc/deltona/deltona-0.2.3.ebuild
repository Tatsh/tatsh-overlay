# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A lot of uncategorised utilities."
HOMEPAGE="https://github.com/Tatsh/deltona"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="admin desktop git media string wine www"

RDEPEND="
	>=dev-python/anyio-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/async-lru-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/binaryornot-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/niquests-3.18.6[${PYTHON_USEDEP}]
	>=dev-python/pathspec-1.0.4[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	admin? ( >=dev-python/paramiko-4.0.0[${PYTHON_USEDEP}] )
	desktop? (
		>=dev-python/pydbus-0.6.0[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		>=dev-python/pyperclip-1.11.0[${PYTHON_USEDEP}]
	)
	git? (
		>=dev-python/gitpython-3.1.46[${PYTHON_USEDEP}]
		>=dev-python/keyring-25.7.0[${PYTHON_USEDEP}]
		>=dev-python/pygithub-2.9.1[${PYTHON_USEDEP}]
	)
	media? (
		>=dev-python/keyring-25.7.0[${PYTHON_USEDEP}]
		>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
		>=dev-python/send2trash-2.1.0[${PYTHON_USEDEP}]
		>=media-libs/mutagen-1.47.0[${PYTHON_USEDEP}]
	)
	string? (
		>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
		>=dev-python/unidecode-1.4.0[${PYTHON_USEDEP}]
		>=net-misc/yt-dlp-2026.03.17[${PYTHON_USEDEP}]
	)
	wine? (
		>=dev-python/pexpect-4.9.0[${PYTHON_USEDEP}]
		>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
		>=dev-python/psutil-7.2.2[${PYTHON_USEDEP}]
		>=dev-python/python-xz-0.6.0[${PYTHON_USEDEP}]
	)
	www? (
		>=dev-python/beautifulsoup4-4.14.3[${PYTHON_USEDEP}]
		>=dev-python/html5lib-1.1[${PYTHON_USEDEP}]
		>=dev-python/keyring-25.7.0[${PYTHON_USEDEP}]
		>=dev-python/pillow-12.2.0[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	test? (
		${RDEPEND}
		>=dev-python/mock-5.2.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-asyncio-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-mock-3.15.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	rm "${D}/usr/bin/slugify" "${D}/usr/lib/python-exec/python"*/slugify || die
	doman "man/${PN}.1"
}
