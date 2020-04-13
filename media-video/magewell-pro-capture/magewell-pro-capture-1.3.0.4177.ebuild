# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit linux-info linux-mod

SUFFIX=4177
DESCRIPTION="Magewell Pro Capture driver."
HOMEPAGE="https://www.magewell.com/downloads/pro-capture#/driver/linux-x86"
SRC_URI="http://www.magewell.com/files/drivers/ProCaptureForLinux_${SUFFIX}.tar.gz"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc weave"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/ProCaptureForLinux_${SUFFIX}"

MODULE_NAMES="ProCapture(misc:src:src)"
DOCS=(quick_start.txt docs/Readme.txt docs/ProCaptureSeriesCardUserGuideforLinux.{eng,chs}.pdf)

src_prepare() {
	sed -e 's:/local::g' -e 's:/src::g' -i scripts/ProCapture.conf || die 'Failed to patch!'
	if use weave; then
		sed -e 's/MWCAP_VIDEO_DEINTERLACE_(BLEND|TOP_FIELD|BOTTOM_FIELD)/MWCAP_VIDEO_DEINTERLACE_WEAVE/g' -i src/sources/avstream/v4l2.c || die 'Failed to patch!'
	fi
	default
}

src_compile() {
	set_arch_to_kernel
	# FIXME Make linux-mod_src_compile work
	emake -C src KERNELDIR="${KV_DIR}" || die 'Failed to build'
}

src_install() {
	linux-mod_src_install

	local suffix
	suffix=32
	if use amd64; then
		suffix=64
	fi
	exeinto /usr/bin
	for name in control info; do
		newexe "bin/mwcap-${name}_${suffix}" "mwcap-${name}"
	done

	insinto /lib/udev/rules.d
	newins scripts/10-procatpure-event-dev.rules 10-procapture-event-dev.rules
	udevadm control --reload-rules

	insinto /usr/share/ProCapture/res
	doins src/res/*.png

	insinto /etc/modprobe.d/
	doins scripts/ProCapture.conf

	if use doc; then
		insinto /usr/share/doc/${P}
		doins -r docs/*
	else
		einstalldocs
	fi
}
