# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="汉字拼音转换模块/工具."
HOMEPAGE="https://pypi.org/project/pypinyin/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
