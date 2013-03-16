# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="X-Sys for X-Chat and similar clients re-written in Python"
HOMEPAGE="https://github.com/Tatsh/misc-scripts"
EGIT_REPO_URI="git://github.com/Tatsh/xsys.git"
EGIT_COMMIT="v1.0"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hexchat xchat"

DEPEND=""
RDEPEND="${DEPEND}
	hexchat? ( net-irc/hexchat[python] )
	xchat? ( net-irc/xchat[python] )
"
PYTHON_DEPEND="2"

src_install() {
	if use hexchat; then
		insinto /usr/lib64/hexchat/plugins/
		doins xsys.py
	fi

	if use xchat; then
		insinto /usr/lib64/xchat/plugins/
		doins xsys.py
	fi

	dodoc README.md
}

pkg_postinst() {
	# TODO Detect if hexchat[plugins] is installed
	if use hexchat; then
		ewarn "If you have HexChat installed with the plugins USE flag, you may"
		ewarn "want to disable the integrated sysinfo plugin to avoid"
		ewarn "conflicts:"
		ewarn
		ewarn "        chmod 0700 /usr/lib/hexchat/plugins/sysinfo.so"
		ewarn
	fi

	einfo "To enable the plugin, enable manually through the plugin manager"
	einfo "in your client or restart your client."
}

# FIXME Doesn't work yet
# 936 Replacing "xchat.prnt()" call with regular print
#
# Traceback (most recent call last):
#   File "/var/tmp/portage/net-irc/xsys-1.0/work/xsys-1.0/xsys-cli", line 129, in <module>
#     eval(compile(ast, '<string>', 'exec'))
#   File "<string>", line 919, in <module>
#   File "<string>", line 745, in sysinfo
#   File "<string>", line 625, in sysinfo_osinfo
#   File "/usr/lib64/python2.7/UserDict.py", line 23, in __getitem__
#     raise KeyError(key)
# KeyError: 'USER'
# src_test() {
# 	./xsys-cli
# }
