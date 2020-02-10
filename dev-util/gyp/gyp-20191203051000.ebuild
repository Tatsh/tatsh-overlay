# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{6..8} )
DISTUTILS_SINGLE_IMPL="1"

inherit distutils-r1

if [[ "${PV}" == "99999999999999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://chromium.googlesource.com/external/gyp"
fi

DESCRIPTION="GYP (Generate Your Projects) meta-build system"
HOMEPAGE="https://gyp.gsrc.io/ https://chromium.googlesource.com/external/gyp"
if [[ "${PV}" == "99999999999999" ]]; then
	SRC_URI=""
else
	SRC_URI="https://chromium.googlesource.com/external/gyp/+archive/e87d37d6bce611abed35e854d5ae1a401e9ce04c.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE=""

S="$WORKDIR"

src_test() {
	# More errors when DeprecationWarnings enabled.
	local -x PYTHONWARNINGS=""
	"${PYTHON}" gyptest.py --all --verbose
}
