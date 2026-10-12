# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra-emotionengine-reloaded"

inherit ghidra-extension

DESCRIPTION="Ghidra extension adding PlayStation 2 Emotion Engine support."
HOMEPAGE="https://github.com/chaoticgd/ghidra-emotionengine-reloaded"
SRC_URI="https://github.com/chaoticgd/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

# The extension shells out to stdump to read STABS symbols and rejects any
# output that is not JSON format version 7. ccc 2.0 rewrote that output into a
# symbol database, so the older slot is the one that works. Upstream's own
# archives bundle a copy of the same program, downloaded by os/download.sh.
RDEPEND+=" dev-util/ccc:1.2"

src_prepare() {
	ghidra-extension_src_prepare

	# Fetches the stdump binaries that upstream's releases bundle. The packaged
	# one is used instead.
	rm os/download.sh || die
}

src_install() {
	ghidra-extension_src_install

	# Where Application.getOSFile() looks for it.
	dosym -r /usr/bin/stdump-1.2 \
		"${GHIDRA_HOME}/Ghidra/Extensions/${GHIDRA_EXT_NAME}/os/linux_x86_64/stdump"
}
