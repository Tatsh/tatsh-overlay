# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libplist/libplist-1.10.ebuild,v 1.3 2013/11/24 18:48:48 ago Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit autotools autotools-utils python-r1 git-2

DESCRIPTION="Support library to deal with Apple Property Lists (Binary & XML)"
HOMEPAGE="http://www.libimobiledevice.org/"
EGIT_REPO_URI="git://github.com/libimobiledevice/${PN}.git"

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

_setup_dir_for_python_impl() {
	[ ! -d "$BUILD_DIR" ] && mkdir "$BUILD_DIR"
	cp -R . "$BUILD_DIR"
	cd "$BUILD_DIR" && eautoreconf
}

_configure_for_python_impl() {
	cd "$BUILD_DIR"
	ECONF_SOURCE="$BUILD_DIR" autotools-utils_src_configure
}

src_prepare() {
	if use python; then
		python_foreach_impl _setup_dir_for_python_impl
	else
		eautoreconf
	fi
}

src_configure() {
    local myconf

	# Have to do multiple builds if there are more than one Python version given
	if use python; then
		python_foreach_impl _configure_for_python_impl
		return
	fi

	myconf+=' --without-cython'

    autotools-utils_src_configure
}

src_compile() {
	if use python; then
		python_foreach_impl autotools-utils_src_compile
		return
	fi

	autotools-utils_src_compile
}

_install_with_plist_module() {
	cd "$BUILD_DIR"
	autotools-utils_src_install

	# Install pxd file for building libimobiledevice properly
	insinto /usr/$(get_libdir)/$(basename $PYTHON)/site-packages/${PN}/includes
	doins "${BUILD_DIR}/cython/plist.pxd"
}

src_install() {
	if use python; then
		python_foreach_impl _install_with_plist_module
		dosym /usr/bin/plistutil /usr/bin/plutil
		return
	fi

	autotools-utils_src_install
	dosym /usr/bin/plistutil /usr/bin/plutil
}

src_test() {
	cd "${WORKDIR}"

	local testfile
	for testfile in "${S}"/test/data/*; do
		LD_LIBRARY_PATH=src ./test/plist_test "${testfile}" || die
	done
}

# kate: replace-tabs false;
