# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils cmake-utils git-2

DESCRIPTION="Core library for accessing the Microsoft Kinect USB camera."
HOMEPAGE="https://github.com/OpenKinect/libfreenect"
EGIT_REPO_URI="git://github.com/OpenKinect/libfreenect.git"
EGIT_COMMIT="3629b75ba667435e3fcb0e5b8277ca83647f940e"

LICENSE="Apache-2.0 GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="audio +c +cpp examples fakenect opencv python"

DEPEND="dev-util/pkgconfig
	dev-util/cmake
	virtual/libusb:1
	examples? ( 
		media-libs/freeglut
		x11-libs/libXi
		x11-libs/libXmu
	)
	opencv? ( media-libs/opencv )
	python? ( dev-python/cython )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use audio; then
		elog "You have enabled the audio USE flag. Resulting binaries may not be legal to re-distribute."
	fi
}

src_prepare() {
	echo 'SYSFS{idVendor}=="045e", SYSFS{idProduct}=="02ae", MODE="0660",GROUP="video"' > 66-kinect.rules
	echo 'SYSFS{idVendor}=="045e", SYSFS{idProduct}=="02ad", MODE="0660",GROUP="video"' >> 66-kinect.rules
	echo 'SYSFS{idVendor}=="045e", SYSFS{idProduct}=="02b0", MODE="0660",GROUP="video"' >> 66-kinect.rules
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_build audio AUDIO)
		$(cmake-utils_use_build c C_SYNC)
		$(cmake-utils_use_build cpp CPP)
		$(cmake-utils_use_build examples EXAMPLES)
		$(cmake-utils_use_build fakenect FAKENECT)
		$(cmake-utils_use_build opencv CV)
		$(cmake-utils_use_build python PYTHON)
	"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	insinto /lib/udev/rules.d
	doins 66-kinect.rules
}

pkg_postinst() {
	elog
	elog "You must be in the video group to use the Kinect as a normal user."
	elog
	elog "To add yourself to the video group:"
	elog "  gpasswd -a <USER> video"
	elog
}
