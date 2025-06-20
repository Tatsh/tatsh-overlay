# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/${PN}"

DESCRIPTION="Assets needed for RetroArch. Also contains the official branding."
HOMEPAGE="https://github.com/libretro/retroarch-assets"

if [[ "${PV}" == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/${LIBRETRO_REPO_NAME}.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/${LIBRETRO_REPO_NAME}/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm64"
fi

LICENSE="CC-BY-4.0"
SLOT="0"

IUSE="materialui ozone rgui xmb"

src_prepare() {
	default

	sed -i -e "s/libretro/retroarch/g" Makefile || die

	declare -A FLAGS=( [materialui]=glui [ozone]= [rgui]= [xmb]= )
	for flag in "${!FLAGS[@]}"; do
		if ! use "${flag}"; then
			local folder="${FLAGS[$flag]:-$flag}"
			rm -r "${folder}" || die
		fi
	done
}
