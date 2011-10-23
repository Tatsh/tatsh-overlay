# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit eutils linux-info

DESCRIPTION="Apple's libraries and headers for iOS 5."
HOMEPAGE="https://github.com/tatsh/xchain"
SRC_URI="xcode_4.2_and_ios_5_sdk_for_snow_leopard.dmg"
RESTRICT="fetch"

LICENSE="EULA APSL-1 APSL-2 GPL-2 MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kernel_linux"

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/p7zip
	app-arch/dmgextractor
	app-arch/cpio
	app-arch/xar"
	
CONFIG_CHECK="HFSPLUS_FS"

pkg_nofetch() {
	elog "You must download the Xcode 4.2 DMG from Apple's developer site."
	elog "Visit http://developer.apple.com/ and sign in, then download the Xcode 4.2 DMG for Snow Leopard (not Lion)."
	elog "Place the file 'xcode_4.2_and_ios_5_sdk_for_snow_leopard.dmg' in ${DISTDIR}"
	elog "If this file is no longer available, please report a bug at https://github.com/tatsh/tatsh-overlay/issues"
}

src_unpack() {
	# TODO Patch dmgextractor to not have any GUI whatosever
	elog "Click OK in any dialog boxes that appear."
	
	cd "${DISTDIR}"
	dmgextractor "${DISTDIR}/xcode_4.2_and_ios_5_sdk_for_snow_leopard.dmg" \
		"${DISTDIR}/xcode-4.2.iso"
	7z x -o"${S}" -y "${DISTDIR}/xcode-4.2.iso" || die "Failed to extract ISO!"
	
	cd "${S}"
	# Guide says these should not be necesssary and should use addpredict
	# but that does not work
	addwrite /dev
	addwrite /etc
	mkdir -p tmpmount
	mount -t hfsplus "disk image.hfs" tmpmount || die "Could not mount!"
	cp -v tmpmount/packages/iPhoneSDK5_0.pkg .
	cp -v tmpmount/packages/iPhoneSDKTools.pkg .
	umount tmpmount || die "Could not unmount!"
	rmdir tmpmount
	
	xar -x -f iPhoneSDK5_0.pkg Payload
	mv -v Payload Payload.gz
	gunzip Payload.gz
	cpio -i < Payload
	rm Payload
	
	xar -x -f iPhoneSDKTools.pkg Payload
	mv -v Payload Payload.gz
	gunzip Payload.gz
	cpio -i < Payload
	rm Payload
	
	mv -v Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.0.sdk arm-apple-darwin
	mv -vf Platforms/iPhoneOS.platform/Developer/usr arm-apple-darwin/usr2
}

src_prepare() {
	cd "${S}"
	
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
	rm -vf libexec/gcc/arm-apple-darwin10/4.2.1/lib*
	
	
	cd "${S}/arm-apple-darwin/Developer"
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
	cd "${S}"
	
	mkdir -p "${D}/usr"
	cp -vR "${S}/arm-apple-darwin" "${D}/usr"
}
