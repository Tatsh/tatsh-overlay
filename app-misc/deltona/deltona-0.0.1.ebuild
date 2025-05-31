# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{2,3} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="A lot of uncategorised utilities."
HOMEPAGE="https://github.com/Tatsh/deltona"
IUSE="admin desktop git media string wine www"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="dev-python/binaryornot[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	media? (
		dev-python/platformdirs[${PYTHON_USEDEP}]
		media-libs/mutagen[${PYTHON_USEDEP}]
	)
	admin? ( dev-python/paramiko[${PYTHON_USEDEP}] )
	desktop? (
		dev-python/pydbus[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/pyperclip[${PYTHON_USEDEP}]
		media-video/mpv[-tools]
	)
	git? (
		dev-python/gitpython[${PYTHON_USEDEP}]
		dev-python/pygithub[${PYTHON_USEDEP}]
	)
	string? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/unidecode[${PYTHON_USEDEP}]
		net-misc/yt-dlp[${PYTHON_USEDEP}]
	)
	wine? (
		dev-python/pexpect[${PYTHON_USEDEP}]
		dev-python/python-xz[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	)
	www? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/html5lib[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
	dev-python/requests-mock[${PYTHON_USEDEP}]
)"

src_install() {
	distutils-r1_src_install
	rm "${D}/usr/bin/slugify" "${D}/usr/lib/python-exec/python"*/slugify || die
	doman "man/${PN}.1"
}

distutils_enable_tests pytest
