# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Fully automatic time tracking for programmers"
HOMEPAGE="https://github.com/wakatime/wakatime"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	test? ( https://github.com/wakatime/wakatime/archive/13.1.0.tar.gz -> ${P}-tests.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ntlm"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	ntlm? ( dev-python/requests-ntlm[${PYTHON_USEDEP}] )"
DEPEND="test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/nose-exclude[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/testfixtures[${PYTHON_USEDEP}] )"
BDEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests nose

python_prepare_all() {
	while IFS=$'\n' read -r name
	do
		sed -r -e 's/from \.packages (import.*)/\1/g' \
			   -e 's/from \.+packages\.(py2[67]\.)?(.*)/from \2/g' \
			-i "$name"
	done < <(grep -FRHn .packages wakatime | cut -d: -f1)
	if use test; then
		while IFS=$'\n' read -r name
		do
			sed -r -e 's/from wakatime\.packages (import.*)/\1/g' \
				   -e 's/from wakatime\.+packages\.(py2[67]\.)?(.*)/from \2/g' \
				   -e "s/'wakatime\.packages\./'/g" \
				-i "$name"
		done < <(grep -FRHn wakatime.packages tests | cut -d: -f1)
	fi
	rm -fR wakatime/packages/
	distutils-r1_python_prepare_all
}
