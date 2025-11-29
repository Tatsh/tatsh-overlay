# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
inherit distutils-r1

DESCRIPTION="An kill-switch that waits for a change on your USB ports."
HOMEPAGE="https://github.com/hephaest0s/usbkill"
SHA="d3df79edab0c1dcec4b56468958c17a5c5dc6dce"
SRC_URI="https://github.com/hephaest0s/usbkill/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
