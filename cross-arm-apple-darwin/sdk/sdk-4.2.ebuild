# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Apple's libraries and headers for iOS 5."
HOMEPAGE="https://github.com/Tatsh/xchain"
SRC_URI="xcode_4.2_and_ios_5_sdk_for_snow_leopard.dmg"
RESTRICT="fetch"

LICENSE="EULA APSL-1 APSL-2 GPL-2 MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/p7zip
	app-arch/cpio
	app-arch/xar"

pkg_nofetch() {
	elog "You must download the Xcode 4.2 DMG from Apple's developer site."
	elog "Visit http://developer.apple.com/ and sign in, then download the Xcode 4.2 DMG for Snow Leopard (not Lion)."
	elog "Place the file 'xcode_4.2_and_ios_5_sdk_for_snow_leopard.dmg' in ${DISTDIR}"
	elog "If this file is no longer available, please report a bug at https://github.com/Tatsh/tatsh-overlay/issues"
}

src_unpack() {
	cd "${DISTDIR}"
	7z x -o"${WORKDIR}" "${DISTDIR}/xcode_4.2_and_ios_5_sdk_for_snow_leopard.dmg"

	cd "${WORKDIR}"
	7z x 5.hfs
	rm 5.hfs

	for i in \
		iPhoneSDK5_0 \
		iPhoneSDKTools \
		iPhoneSimulatorSDK5_0; do
		cp -v Xcode/Packages/$i.pkg .
		xar -x -f "$i.pkg" Payload
		mv -v Payload Payload.gz
		gunzip Payload.gz
		cpio -i < Payload
		rm Payload
	done

	mv -v Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.0.sdk arm-apple-darwin
	mv -vf Platforms/iPhoneOS.platform/Developer/usr arm-apple-darwin/usr2
	mv -v Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.0.sdk/usr/include sim-include
}

src_prepare() {
	cd "${WORKDIR}"

	cp -Rfv sim-include/* arm-apple-darwin/usr/include
	rm -vR sim-include

	# Clean up and fixes
	cd arm-apple-darwin/usr/lib
	ln -s libgcc_s.1.dylib libgcc_s.10.4.dylib

	cd ..
	mkdir -p bin
	mkdir -p libexec

	# arm-apple-darwin
	cd ..
	mv -vf usr2/include/* usr/include
	mv -vf usr2/lib/* usr/lib
	mv -vf usr2/llvm-gcc-4.2 usr
	rm -Rfv usr2

	cd usr/llvm-gcc-4.2
	rm -Rvf bin
	ln -s ../bin
	rm -Rvf lib/gcc/i686-apple-darwin10
	mv -vf lib/* ../lib
	rm -Rvf lib
	ln -s ../lib
	rm -Rvf libexec/gcc/i686-apple-darwin10
	mv -vf libexec/* ../libexec
	rm -Rvf libexec
	ln -s ../libexec
	mv share ..
	ln -s ../share

	# arm-apple-darwin/usr
	cd ..
	rm -vf libexec/gcc/arm-apple-darwin10/4.2.1/install-tools/fixincl
	rm -vf libexec/gcc/arm-apple-darwin10/4.2.1/as
	rm -vf libexec/gcc/arm-apple-darwin10/4.2.1/cc*
	rm -vf libexec/gcc/arm-apple-darwin10/4.2.1/collect2
	rm -vf libexec/gcc/arm-apple-darwin10/4.2.1/ld
	rm -vf libexec/gcc/*.dylib

	cd "${WORKDIR}/arm-apple-darwin/Developer"
	mv -f Library/Frameworks/* ../System/Library/Frameworks
	mv -f Library/PrivateFrameworks/* ../System/Library/PrivateFrameworks
	rm -vR Library
	ln -s ../System/Library
	mv -v usr/lib/* ../usr/lib
	rm -vR usr
	ln -s ../usr

	cd ..
	rm -vf *.plist
}

src_install() {
	mkdir -p "${D}/usr"
	cp -vR "${WORKDIR}/arm-apple-darwin" "${D}/usr"
}
