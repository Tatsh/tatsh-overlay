# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils

DESCRIPTION="A multi-platform library for USB and Bluetooth HID-Class devices"
HOMEPAGE="http://www.signal11.us/oss/hidapi/"
SRC_URI="https://github.com/libusb/hidapi/archive/${P}.tar.gz"

LICENSE="|| ( BSD GPL-3 HIDAPI )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="doc fox static-libs"

RDEPEND="virtual/libusb:1
	virtual/libudev:0"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig
	fox? ( x11-libs/fox )"

S="${WORKDIR}/${PN}-${PN}-${PV}"

src_prepare() {
	if ! use fox; then
		sed -i -e 's:PKG_CHECK_MODULES(\[fox\], .*):AC_SUBST(fox_CFLAGS,[ ])AC_SUBST(fox_LIBS,[ ]):' configure.ac || die
	fi

	# Fix bashisms in the configure.ac file.
	sed -i -e 's:\([A-Z_]\+\)+="\(.*\)":\1="${\1}\2":g' \
		-e 's:\([A-Z_]\+\)+=`\(.*\)`:\1="${\1}\2":g' configure.ac || die

	# Portage handles license texts itself, no need to install them
	sed -i -e 's/LICENSE.*/ # blank/' Makefile.am || die

	eautoreconf
	default
}

src_configure() {
	econf \
		$(use_enable fox testgui)
}

src_compile() {
	default
	if use doc; then
		doxygen doxygen/Doxyfile || die
	fi
}

src_install() {
	default
	if use doc; then
		dohtml -r html/.
	fi
}
