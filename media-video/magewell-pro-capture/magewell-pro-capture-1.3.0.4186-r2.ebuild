# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit linux-info linux-mod

DESCRIPTION="Magewell Pro Capture driver."
HOMEPAGE="https://www.magewell.com/downloads/pro-capture#/driver/linux-x86"
SUFFIX="${PV##*.}"
SRC_URI="http://www.magewell.com/files/drivers/ProCaptureForLinux_${SUFFIX}.tar.gz"

LICENSE="Magewell-Pro-Capture"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc weave"

S="${WORKDIR}/ProCaptureForLinux_${SUFFIX}"

BUILD_TARGETS="all" # no clean because a file has to be hacked in src_prepare() that would otherwise get deleted; the archive is clean anyway
BUILD_PARAMS="KERNELDIR=${KERNEL_DIR}"
MODULE_NAMES="ProCapture(video:src:src)"
DOCS=(quick_start.txt docs/Readme.txt docs/ProCaptureSeriesCardUserGuideforLinux.{eng,chs}.pdf)

PATCHES=( "${FILESDIR}/${P}-kernel-5.10.patch" )

src_prepare() {
	sed -e 's:/local::g' -e 's:/src::g' -i scripts/ProCapture.conf || die 'Failed to patch!'
	if use weave; then
		sed -e 's/MWCAP_VIDEO_DEINTERLACE_\(BLEND\|TOP_FIELD\|BOTTOM_FIELD\)/MWCAP_VIDEO_DEINTERLACE_WEAVE/g' -i src/sources/avstream/v4l2.c || die 'Failed to patch!'
	fi
	touch src/.ProCaptureLib.o.cmd # modpost looks for this file but it does not get created
	default
}

src_install() {
	linux-mod_src_install

	local suffix
	suffix=32
	use amd64 && suffix=64
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
