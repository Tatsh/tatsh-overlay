# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="使用 pinyin-data 和 phrase-pinyin-data 中的拼音数据文件覆盖 pypinyin 中的自带拼音数据，实现只使用某个或某些拼音数据文件中的拼音数据的需求."
HOMEPAGE="https://pypi.org/project/pypinyin-dict/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
