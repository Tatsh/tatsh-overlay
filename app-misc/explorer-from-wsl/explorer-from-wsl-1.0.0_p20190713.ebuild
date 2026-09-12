# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1

# Upstream has never tagged a release; setup.py declares 1.0.0.
MY_COMMIT="e312928eb4e00938d4df88db2209ce0b19a66609"

DESCRIPTION="Open Windows Explorer from a WSL shell using a Unix-style path."
HOMEPAGE="https://github.com/ijknabla/explorer-from-wsl"
SRC_URI="https://github.com/ijknabla/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

pkg_postinst() {
	elog "This runs wslpath and explorer.exe, so it only does anything useful"
	elog "inside a WSL distribution."
}
