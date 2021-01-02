# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )
inherit distutils-r1

DESCRIPTION="Fully automatic time tracking for programmers"
HOMEPAGE="https://github.com/wakatime/wakatime"
SRC_URI="https://pypi.python.org/packages/source/w/wakatime/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ntlm"

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	ntlm? ( dev-python/requests-ntlm[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"

python_prepare_all() {
	while IFS=$'\n' read -r name
	do
		sed -r -e 's/from \.packages (import.*)/\1/g' \
			   -e 's/from \.+packages\.(py2[67]\.)?(.*)/from \2/g' \
			-i "$name"
	done < <(fgrep -RHn .packages wakatime | cut -d : -f 1)
	rm -fR wakatime/packages/
	distutils-r1_python_prepare_all
}
