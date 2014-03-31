# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-pda/libimobiledevice/libimobiledevice-9999.ebuild,v 1.0 2013/10/31 16:38:49 srcs Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{2,3} )
EGIT_MASTER="master"
inherit autotools autotools-utils eutils git-2 python-r1 multilib

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/6"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="gnutls python"

RDEPEND=">=app-pda/libplist-1.10[python?,${PYTHON_USEDEP}]
	>=app-pda/libusbmuxd-1.0.9
	gnutls? (
		dev-libs/libgcrypt
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
	)
	!gnutls? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	python? (
		${PYTHON_DEPS}
		>=dev-python/cython-0.17[${PYTHON_USEDEP}]
	)"

DOCS=( AUTHORS NEWS README )

pkg_setup() {
	# Prevent linking to the installed copy
	if has_version "<${CATEGORY}/${P}"; then
		rm -f "${EROOT}"/usr/$(get_libdir)/${PN}$(get_libname)
	fi
}

_setup_dir_for_python_impl() {
	[ ! -d "$BUILD_DIR" ] && mkdir "$BUILD_DIR"
	cp -R . "$BUILD_DIR"
	cd "$BUILD_DIR" && eautoreconf
}

_configure_for_python_impl() {
	local myconf="$1"
	cd "$BUILD_DIR"
	ECONF_SOURCE="$BUILD_DIR" autotools-utils_src_configure
}

src_prepare() {
	if use python; then
		epatch "${FILESDIR}/cython-pxd-path.patch"
		python_foreach_impl _setup_dir_for_python_impl
	else
		eautoreconf
	fi
}

src_configure() {
	local myconf

	use gnutls && myconf='--disable-openssl'

	myconf+=' --enable-static=no'

	# Have to do multiple builds if there are more than one Python version given
	if use python; then
		python_foreach_impl _configure_for_python_impl "$myconf"
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

_install_with_module() {
	cd "$BUILD_DIR"
	autotools-utils_src_install
	prune_libtool_files --all

	# pxd file for further dependent packages
	insinto /usr/$(get_libdir)/$(basename $PYTHON)/site-packages/${PN}/includes
	doins "${BUILD_DIR}/cython/imobiledevice.pxd"
}

src_install() {
	if use python; then
		python_foreach_impl _install_with_module
		return
	fi

	default
	prune_libtool_files --all
}
