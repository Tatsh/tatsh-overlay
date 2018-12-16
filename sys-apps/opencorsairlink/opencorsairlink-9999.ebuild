# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_PN="OpenCorsairLink"
if [[ "$PV" = 9999 ]]; then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/audiohacked/OpenCorsairLink.git"
	EGIT_BRANCH="testing"
else
	MY_HASH="acb2cebef29d03c9953f43cb06ae94873110cde7"
	SRC_URI="https://github.com/audiohacked/OpenCorsairLink/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${MY_HASH}"
	KEYWORDS="~x86 ~amd64"
fi
inherit udev "$GIT_ECLASS"

DESCRIPTION="Linux support for Corsair water coolers."
HOMEPAGE="https://github.com/audiohacked/OpenCorsairLink"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libusb:1
	virtual/pkgconfig"
RDEPEND=""

src_compile() {
	emake LDFLAGS="-lusb-1.0 -lm $LDFLAGS"
}

src_install () {
	dobin "${MY_PN}.elf"
	dosym "/usr/bin/${MY_PN}.elf" /usr/bin/ocl
	dodoc README.md LICENSE CONTRIBUTING.md
}
