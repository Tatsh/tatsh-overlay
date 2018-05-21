# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 udev

DESCRIPTION="Linux support for the Corsair H80i and H100i water cooler."
HOMEPAGE="https://github.com/audiohacked/OpenCorsairLink"
EGIT_REPO_URI="https://github.com/audiohacked/OpenCorsairLink.git"
EGIT_BRANCH="testing"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/libusb:1
	virtual/pkgconfig"
RDEPEND=""

src_compile() {
	emake LDFLAGS="-lusb-1.0 -lm $LDFLAGS"
}

src_install () {
	mv OpenCorsairLink.elf ocl
	dobin ocl
	dodoc README.md
}
