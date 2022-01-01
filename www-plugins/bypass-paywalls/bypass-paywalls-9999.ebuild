# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bypass Paywalls browser extension."
HOMEPAGE="https://github.com/iamadamdev/bypass-paywalls-chrome"
IUSE="chrome chromium"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

S="${WORKDIR}"

EXT_ID="dcpihecpambacapedldabdbpakmachpb"

src_unpack() {
	:
}

src_install() {
	cat > "${EXT_ID}.json" <<EOF
{
  "external_update_url": "https://raw.githubusercontent.com/iamadamdev/${PN}-chrome/master/src/updates/updates.xml"
}
EOF
	if use chrome; then
		insinto /usr/share/google-chrome/extensions
		doins "${EXT_ID}.json"
	fi
	if use chromium; then
		insinto /usr/share/chromium/extensions
		doins "${EXT_ID}.json"
	fi
}

pkg_postinst() {
	einfo
	einfo 'This installation only works if you have not manually uninstalled'
	einfo 'the extension before when it was installed from "external"'
	einfo '(i.e. this method) source.'
	einfo
	einfo "If you have uninstalled the extension before, close the browser"
	einfo "completely, search your profile \"Preferences\" file for the string"
	einfo "\"${EXT_ID}\" (with double quotes) and remove it. Then restart the"
	einfo "browser and the extension should get installed for that profile."
	einfo
	einfo 'If the installation does not install even without the string'
	einfo 'present in your profile data, then non-store extensions are blocked'
	einfo 'by your enterprise policy. There is no way around this other than'
	einfo 'to use another profile.'
	einfo
}
