# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="Speed up PyYAML by automatically enabling LibYAML bindings."
HOMEPAGE="https://pypi.org/project/pylibyaml/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/libyaml"

python_prepare_all() {
	rm -rf tests || die
	distutils-r1_python_prepare_all
}
