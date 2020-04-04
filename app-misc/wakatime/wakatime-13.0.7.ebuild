# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Fully automatic time tracking for programmers"
HOMEPAGE="https://github.com/wakatime/wakatime"
SRC_URI="https://pypi.python.org/packages/source/w/wakatime/${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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
