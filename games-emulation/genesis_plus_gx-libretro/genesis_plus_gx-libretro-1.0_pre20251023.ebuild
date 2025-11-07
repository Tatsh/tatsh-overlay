# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/Genesis-Plus-GX"
LIBRETRO_COMMIT_SHA="cecccacf767b1c8e86af3e315223b052a7f81b95"
inherit libretro-core

DESCRIPTION="libretro implementation of Genesis Plus GX. \
(Sega Genesis/Sega CD)"
HOMEPAGE="https://github.com/libretro/Genesis-Plus-GX"
LICENSE="GPGX"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=genesis_plus_gx

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to have the following files in your 'system_directory' folder:"
		ewarn "Required:"
		ewarn "bios_CD_E.bin (MegaCD EU BIOS)"
		ewarn "bios_CD_U.bin (SegaCD US BIOS)"
		ewarn "bios_CD_J.bin (MegaCD JP BIOS)"
		ewarn
		elog "Optional:"
		elog "bios_E.sms (MasterSystem EU BIOS)"
		elog "bios_U.sms (MasterSystem US BIOS)"
		elog "bios_J.sms (MasterSystem JP BIOS)"
		elog "bios.gg (GameGear BIOS)"
		elog "sk.bin (Sonic & Knuckles (2 MiB) ROM)"
		elog "sk2chip.bin (Sonic & Knuckles UPMEM (256 KiB) ROM) = b4e76e416b887f4e7413ba76fa735f16"
		elog "areplay.bin (Action Replay (Pro) ROM)"
		elog "ggenie.bin (Game Genie ROM)"
		elog ""
		ewarn ""
	fi
}
