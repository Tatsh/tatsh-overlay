# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libplist/libplist-1.10.ebuild,v 1.3 2013/11/24 18:48:48 ago Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{2,3} )
inherit autotools autotools-utils python-r1 git-2

DESCRIPTION="Support library to deal with Apple Property Lists (Binary & XML)"
HOMEPAGE="http://www.libimobiledevice.org/"
EGIT_REPO_URI="git://github.com/Tatsh/libplist.git"
EGIT_BRANCH="python-3-support"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-fbsd"
IUSE="python"

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	>=dev-python/cython-0.14.1-r1[${PYTHON_USEDEP}]"

DOCS=( AUTHORS NEWS README )

MAKEOPTS+=" -j1" #406365

# Cannot build this out of source yet
# https://github.com/libimobiledevice/libplist/issues/7
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	eautoreconf
}

src_configure() {
    use python && python_export_best
    local myconf
    use python || myconf+=' --without-cython'
    autotools-utils_src_configure
}

src_test() {
	cd "${WORKDIR}"

	local testfile
	for testfile in "${S}"/test/data/*; do
		LD_LIBRARY_PATH=src ./test/plist_test "${testfile}" || die
	done
}

# kate: replace-tabs false;
