# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Borrowed from
# https://github.com/benkohler/iamben-overlay/blob/master/sys-apps/memtest86-bin/memtest86-bin-8.2.ebuild

EAPI=7
inherit mount-boot

DESCRIPTION="Stand alone memory testing software for x86 computers"
HOMEPAGE="http://www.memtest86.com/"
SRC_URI="https://www.memtest86.com/downloads/memtest86-usb.zip -> ${P}.zip"

LICENSE="PassMark-EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="grub systemd"

BDEPEND="app-arch/unzip
	sys-fs/fatcat"

MY_PN="${PN/-bin}"
S="${WORKDIR}"

DOCS=( MemTest86_User_Guide_UEFI.pdf )

src_unpack() {
	default
	fatcat memtest86-usb.img -O 1048576 -r /EFI/BOOT/BOOTX64.efi > ${PN}.efi || die
}

src_install() {
	if use grub || { use grub && ! use systemd; }; then
		insinto /boot
		newins "${PN}.efi" "${MY_PN}.efi"
		exeinto /etc/grub.d/
		newexe "${FILESDIR}/${PN}-grub.d" 39_${MY_PN}
	fi
	if use systemd; then
		local -r esp=$(bootctl | egrep ESP | tail -1 | awk '{ print $2 }')
		if [[ "$esp" != /boot/* ]]; then
			die "ESP expected to be in /boot"
		fi
		insinto "${esp}"
		newins "${PN}.efi" "${MY_PN}.efi"
		insinto "${esp}/loader/entries"
		printf "title MemTest86\nefi /${MY_PN}.efi\n" > "${MY_PN}.conf"
		doins "${MY_PN}.conf"
	fi
	einstalldocs
}

pkg_postinst() {
	einfo
	einfo 'Be aware that MemTest86 will write its log file to your ESP and it '
	einfo 'must have enough free space to do so. Otherwise, it will hang.'
	einfo
}
