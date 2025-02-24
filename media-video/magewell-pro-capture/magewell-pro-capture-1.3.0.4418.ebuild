# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-mod-r1 udev

DESCRIPTION="Magewell Pro Capture driver."
HOMEPAGE="https://www.magewell.com/downloads/pro-capture#/driver/linux-x86"
SRC_URI="https://www.magewell.com/files/drivers/ProCaptureForLinux_${PV/.0}.tar.gz"

LICENSE="Magewell-Pro-Capture"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc weave"

RDEPENDS="media-libs/alsa-lib"

S="${WORKDIR}/ProCaptureForLinux_${PV/.0}"

DOCS=(quick_start.txt docs/Readme.txt docs/ProCaptureSeriesCardUserGuideforLinux.{eng,chs}.pdf)

src_prepare() {
	sed -e 's:/local::g' -e 's:/src::g' -i scripts/ProCapture.conf || die 'Failed to patch!'
	if use weave; then
		sed -e 's/MWCAP_VIDEO_DEINTERLACE_\(BLEND\|TOP_FIELD\|BOTTOM_FIELD\)/MWCAP_VIDEO_DEINTERLACE_WEAVE/g' -i src/sources/avstream/v4l2.c || die 'Failed to patch!'
		sed -r -e '263s/(.*)/MWCAP_VIDEO_DEINTERLACE_WEAVE,/' -i src/sources/avstream/v4l2.c || die 'Failed to patch!'
	fi
	touch src/.ProCaptureLib.o.cmd # modpost looks for this file but it does not get created
	default
}

src_compile() {
	local modlist=( ProCapture=video:src:src )
	local modargs=( KERNELDIR="${KERNEL_DIR}" all )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

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
		insinto "/usr/share/doc/${P}"
		doins -r docs/*
	fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
