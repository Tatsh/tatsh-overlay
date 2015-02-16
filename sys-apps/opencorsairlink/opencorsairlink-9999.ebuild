# kate: replace-tabs false;
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 udev

DESCRIPTION="Linux support for the Corsair H80i and H100i water cooler."
HOMEPAGE="https://github.com/audiohacked/OpenCorsairLink"
EGIT_REPO_URI="git://github.com/Tatsh/OpenCorsairLink.git"
EGIT_BRANCH="udev"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="X"

DEPEND=">=dev-libs/hidapi-0.8.0_pre20130121"
RDEPEND="${DEPEND}"

src_compile () {
	qmake
	emake
}

src_install () {
	dobin OpenCorsairLinkCli
	if use X; then
		dobin OpenCorsairLinkGui
	fi

	udev_dorules udev/99-corsair-link.rules
	udev_reload

	dodoc README.md LICENSE
}
