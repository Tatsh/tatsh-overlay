# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Patched Cirrus Logic CS8409 HDA driver for MacBook Pro internal audio"
HOMEPAGE="https://github.com/davidjo/snd_hda_macbookpro"
SHA="89b22ff90b86468b186706861dd18663562defa7"
SRC_URI="https://github.com/davidjo/snd_hda_macbookpro/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/snd_hda_macbookpro-${SHA}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

CONFIG_CHECK="SND_HDA_CODEC_CS8409"
ERROR_SND_HDA_CODEC_CS8409="CONFIG_SND_HDA_CODEC_CS8409 must be set to m. This package replaces
the in-kernel module, so it also needs the full kernel sources in KV_DIR."

MODULES_KERNEL_MIN=6.17

pkg_setup() {
	linux-mod-r1_pkg_setup
	linux_chkconfig_builtin SND_HDA_CODEC_CS8409 &&
		die "CONFIG_SND_HDA_CODEC_CS8409 is built in; set it to m"
}

src_prepare() {
	[[ -f ${KV_DIR}/sound/hda/codecs/cirrus/cs8409.c ]] ||
		die "${KV_DIR} does not contain sound/hda sources"
	mkdir build || die
	cp -r "${KV_DIR}/sound/hda" build/ || die
	find build/hda \( -name '*.o' -o -name '*.ko' -o -name '*.mod*' -o -name '.*.cmd' \
		-o -name modules.order \) -delete || die

	local hda=build/hda
	cp makefiles/Makefile "${hda}" || die
	cp makefiles/Makefile_common "${hda}/common/Makefile" || die
	cp makefiles/Makefile_codecs "${hda}/codecs/Makefile" || die
	cp makefiles/Makefile_cirrus "${hda}/codecs/cirrus/Makefile" || die
	cp patch_cirrus/{cirrus_apple,patch_cirrus_{boot84,new84,real84,hda_generic_copy,real84_i2c}}.h \
		"${hda}/codecs/cirrus" || die

	pushd "${hda}" >/dev/null || die
	eapply "${S}"/patch_cs8409.{c,h}.diff
	popd >/dev/null || die
	default
}

src_compile() {
	local modlist=( snd-hda-codec-cs8409=updates::build/hda/codecs/cirrus:all )
	local modargs=( KERNELBUILD="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	dodoc NOTES.md README.md
}
