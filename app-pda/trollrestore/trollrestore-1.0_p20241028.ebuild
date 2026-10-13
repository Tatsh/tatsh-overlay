# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_14 )

inherit python-single-r1

SHA="082f2520556b9aa8e2b8d6661b81a954ee35966b"

DESCRIPTION="TrollStore installer for iOS 15.2 - 16.7 RC and 17.0"
HOMEPAGE="https://github.com/JJTech0130/TrollRestore"
SRC_URI="https://github.com/JJTech0130/TrollRestore/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/TrollRestore-${SHA}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="
	${PYTHON_DEPS}
	app-pda/usbmuxd
	$(python_gen_cond_dep '
		>=app-pda/pymobiledevice3-11.15.5[${PYTHON_USEDEP}]
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')
"

# Port to the async pymobiledevice3 API (the sync one upstream used is gone)
# and add a shebang so python_newscript can rewrite it.
PATCHES=( "${FILESDIR}/${PN}-pymobiledevice3-async.patch" )

src_install() {
	python_domodule sparserestore
	python_newscript trollstore.py trollrestore
	einstalldocs
}
