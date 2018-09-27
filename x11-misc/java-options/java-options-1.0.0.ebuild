# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Sets _JAVA_OPTIONS variable globally."
HOMEPAGE="https://github.com/Tatsh"
SRC_URI="https://gist.githubusercontent.com/Tatsh/9c05e33567c6526b5694cb7e93347c69/raw/2b94160fa77cf5418a17a40caf1139c3372cbee5/${PN}.sh"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+gtk aa-off aa-on +aa-gasp aa-lcd aa-lcd-hrgb aa-lcd-hbgr aa-lcd-vrgb
	aa-lcd-vbgr"
REQUIRED_USE="^^ ( aa-off aa-on aa-gasp aa-lcd aa-lcd-hrgb aa-lcd-hbgr
	aa-lcd-vrgb aa-lcd-vbgr )"

RDEPEND="|| ( virtual/jre:1.8 virtual/jdk:1.8 )"
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_compile () {
	local _java_options useSystemAAFontSettings aatext
	if use gtk; then
		_java_options='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
	fi
	if use aa-off; then
		aatext='false'
		useSystemAAFontSettings=off
	else
		if grep -q -E 'aa-[ogl]' <<< "$USE"; then
			aatext='true'
			use aa-on && useSystemAAFontSettings=on
			use aa-gasp && useSystemAAFontSettings=gasp
			use aa-lcd && useSystemAAFontSettings=lcd
			use aa-lcd-hrgb && useSystemAAFontSettings=lcd_hrgb
			use aa-lcd-hbgr && useSystemAAFontSettings=lcd_hbgr
			use aa-lcd-vrgb && useSystemAAFontSettings=lcd_vrgb
			use aa-lcd-vbgr && useSystemAAFontSettings=lcd_vbgr
		fi
	fi
	. "${DISTDIR}/java-options.sh"
	echo _JAVA_OPTIONS="'${_JAVA_OPTIONS}'" > 99java-options
}

src_install () {
	doenvd 99java-options
}
