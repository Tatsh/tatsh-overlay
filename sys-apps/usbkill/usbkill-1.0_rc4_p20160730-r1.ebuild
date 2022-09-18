# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="An kill-switch that waits for a change on your USB ports."
HOMEPAGE="https://github.com/hephaest0s/usbkill"
SHA="d3df79edab0c1dcec4b56468958c17a5c5dc6dce"
SRC_URI="https://github.com/hephaest0s/usbkill/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

S="${WORKDIR}/${PN}-${SHA}"
