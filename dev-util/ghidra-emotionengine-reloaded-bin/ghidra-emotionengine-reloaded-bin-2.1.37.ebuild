# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream publishes one prebuilt archive per supported Ghidra release, and an
# archive is only valid for the exact Ghidra version it was built against.
GHIDRA_PV="12.1.2"
GHIDRA_EXT_NAME="ghidra-emotionengine-reloaded"
MY_PN="${PN%-bin}"

inherit ghidra-extension

# Date stamp baked into the release asset name by upstream's CI.
GEER_DATE="20260825"

DESCRIPTION="Ghidra extension adding PlayStation 2 Emotion Engine support."
HOMEPAGE="https://github.com/chaoticgd/ghidra-emotionengine-reloaded"
SRC_URI="https://github.com/chaoticgd/${MY_PN}/releases/download/v${PV}/ghidra_${GHIDRA_PV}_PUBLIC_${GEER_DATE}_${MY_PN}.zip
	-> ${P}-ghidra-${GHIDRA_PV}.zip"
S="${WORKDIR}/${MY_PN}"

# Apache-2.0 covers the extension itself. MIT covers the bundled stdump
# executable, which comes from dev-util/ccc (https://github.com/chaoticgd/ccc).
LICENSE="Apache-2.0 MIT"
KEYWORDS="~amd64"

QA_PREBUILT="usr/share/ghidra/Ghidra/Extensions/${GHIDRA_EXT_NAME}/os/linux_x86_64/stdump"

src_prepare() {
	ghidra-extension_src_prepare

	# Only the Linux stdump is usable on this platform.
	rm -r os/mac_x86_64 os/win_x86_64 || die

	# Helper that fetches stdump over the network; useless once installed.
	rm os/download.sh || die
}

src_install() {
	ghidra-extension_src_install

	fperms +x "${GHIDRA_HOME}/Ghidra/Extensions/${GHIDRA_EXT_NAME}/os/linux_x86_64/stdump"
}
