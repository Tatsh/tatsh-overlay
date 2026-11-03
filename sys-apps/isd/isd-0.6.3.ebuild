# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Interactive systemd TUI"
HOMEPAGE="https://kainctl.github.io/isd/ https://github.com/kainctl/isd"
SRC_URI="https://github.com/kainctl/isd/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pfzy-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.10.4[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.7.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/textual-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/xdg-base-dirs-6.0.0[${PYTHON_USEDEP}]
	sys-apps/systemd"
# types-pyyaml is a type-stub package listed in upstream dependencies;
# it is not imported at runtime and is not needed here.

EPYTEST_PLUGINS=( pytest-asyncio pytest-textual-snapshot )
distutils_enable_tests pytest
