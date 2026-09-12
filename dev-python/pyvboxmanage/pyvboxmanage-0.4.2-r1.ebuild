# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Orchestrate VBoxManage commands from a YAML configuration file."
HOMEPAGE="https://github.com/ndejong/pyvboxmanage https://pypi.org/project/pyvboxmanage/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-7.1.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	|| (
		app-emulation/virtualbox
		app-emulation/virtualbox-kvm
	)
"
