# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A VA-API implemention using NVIDIA's NVDEC"
HOMEPAGE="https://github.com/elFarto/nvidia-vaapi-driver"
SRC_URI="https://github.com/elFarto/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="experimental"

BDEPEND=">=media-libs/nv-codec-headers-11.1.5.1"
DEPEND="media-libs/gst-plugins-bad
	media-libs/libglvnd"
RDEPEND="${DEPEND}"

src_prepare() {
	if use experimental; then
		eapply "${FILESDIR}/${PN}-chrome-experimental.patch"
	fi
	default
}
