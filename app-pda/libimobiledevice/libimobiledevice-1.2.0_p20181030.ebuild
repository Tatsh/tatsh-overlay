# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-pda/libimobiledevice/libimobiledevice-9999.ebuild,v 1.0 2013/10/31 16:38:49 srcs Exp $

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )
if [[ "$PV" = 9999 ]]; then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
	MY_HASH="92c5462adef87b1e577b8557b6b9c64d5a089544"
	SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_HASH}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_HASH}"
fi
inherit autotools eutils python-r1 multilib "$GIT_ECLASS"

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/6"
IUSE="gnutls"

PATCHES=(
	"${FILESDIR}/cython-pxd-path.patch"
	"${FILESDIR}/python3.patch"
)

RDEPEND=">=app-pda/libplist-1.10[${PYTHON_USEDEP}]
	>=app-pda/libusbmuxd-1.0.9
	gnutls? (
		dev-libs/libgcrypt
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
	)
	!gnutls? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	${PYTHON_DEPS}
	>=dev-python/cython-0.17[${PYTHON_USEDEP}]"

DOCS=( AUTHORS NEWS README )

pkg_setup() {
	# Prevent linking to the installed copy
	if has_version "<${CATEGORY}/${P}"; then
		rm -f "${EROOT}"/usr/$(get_libdir)/${PN}$(get_libname)
	fi
}

src_prepare() {
	_setup_dir_for_python_impl() {
		[ ! -d "$BUILD_DIR" ] && mkdir "$BUILD_DIR"
		cp -R . "$BUILD_DIR"
		cd "$BUILD_DIR"
		eautoreconf || die
	}

	python_foreach_impl _setup_dir_for_python_impl
	default
}

src_configure() {
	_configure_for_python_impl() {
		local myconf="$1"
		cd "$BUILD_DIR"
		ECONF_SOURCE="$BUILD_DIR" econf
	}
	local myconf

	use gnutls && myconf='--disable-openssl'
	myconf+=' --enable-static=no'

	# Have to do multiple builds if there are more than one Python version given
	python_foreach_impl _configure_for_python_impl "$myconf"
}

src_compile() {
	make_helper() {
		emake -C "$BUILD_DIR"
	}
	python_foreach_impl make_helper
}

src_install() {
	_install_with_module() {
		cd "$BUILD_DIR"
		emake install DESTDIR="${D}"
		find "${D}" -name '*.la' -delete || die

		# pxd file for further dependent packages
		insinto /usr/$(get_libdir)/$(basename $PYTHON)/site-packages/${PN}/includes
		doins "${BUILD_DIR}/cython/imobiledevice.pxd"
	}

	python_foreach_impl _install_with_module
	default
	find "${D}" -name '*.la' -delete || die
}
