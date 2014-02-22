# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Online password manager and form filler that makes web browsing easier and more secure"
HOMEPAGE="https://lastpass.com/misc_download2.php"
SRC_URI="https://lastpass.com/lplinux.tar.bz2 https://lastpass.com/lp_linux.xpi https://lastpass.com/lpchrome_linux.crx"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="firefox +chromium"
RESTRICT="strip"

DEPEND=""
RDEPEND="${DEPEND}
	chromium? ( >=www-client/chromium-32.0.1700.102 )
	firefox? ( || ( >=www-client/firefox-24.1.1
		>=www-client/firefox-bin-24.1.1 ) )
"

S="${WORKDIR}"

src_install() {
	bin=nplastpass
	use amd64 && bin="${bin}64"

	if use chromium; then
		echo "{ \"ExtensionInstallSources\": [\"https://lastpass.com/*\", \"https://*.lastpass.com/*\", \"https://*.cloudfront.net/lastpass/*\"] }" > lastpass_policy.json
		insinto /etc/chromium/policies/managed
		doins lastpass_policy.json

		echo "{ \"name\": \"com.lastpass.nplastpass\", \"description\": \"LastPass\", \"path\": \"/etc/opt/chrome/native-messaging-hosts/$NPLASTPASS\", \"type\": \"stdio\", \"allowed_origins\": [ \"chrome-extension://hdokiejnpimakedhajhdlcegeplioahd/\", \"chrome-extension://debgaelkhoipmbjnhpoblmbacnmmgbeg/\", \"chrome-extension://hnjalnkldgigidggphhmacmimbdlafdo/\" ] }" > com.lastpass.nplastpass.json
		exeinto /etc/chromium/native-messaging-hosts
		doexe "$bin"
		insinto /etc/chromium/native-messaging-hosts
		doins com.lastpass.nplastpass.json

		unzip -qq -o "${DISTDIR}/lpchrome_linux.crx" -d .
		exeinto /usr/lib64/mozilla/plugins

		if use amd64; then
			doexe libnplastpass64.so
		else
			doexe libnplastpass.so
		fi
	fi
}

pkg_postinst() {
	if use chromium; then
		einfo "Visit https://lastpass.com/dl/inline/?full=1 to finish installing for Chrome/Chromium"
	fi
}
