# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Manipulate audio with a simple and easy high level interface"
HOMEPAGE="https://github.com/jiaaro/pydub"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-video/ffmpeg
	dev-python/audioop-lts[${PYTHON_USEDEP}]"
