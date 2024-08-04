# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="cplugins(+),libmpv"
inherit mpv-plugin toolchain-funcs

DESCRIPTION="Set mpv to quiet when stdout/stdout is not a TTY."
HOMEPAGE="https://github.com/AN3223/dotfiles"
SHA="f55f42f9bdc3a1b7e33cb6c74aaca06c0187d3a2"
SRC_URI="https://github.com/AN3223/dotfiles/archive/${SHA}.tar.gz -> AN3223-dotfiles-${SHA:0:7}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

BDEPEND="dev-qt/qtdbus:5"

MPV_PLUGIN_FILES=( "${PN}.so" )

S="${WORKDIR}/dotfiles-${SHA}/.config/mpv/scripts"

src_compile() {
	read -ra cflags <<< "${CFLAGS-}"
	read -ra ldflags <<< "${LDFLAGS-}"
	mapfile -t mpv_cflags < <(pkg-config --cflags mpv)
	"$(tc-getCC)" -o "${PN}.so" "${PN}.c" "${cflags[@]}" "${mpv_cflags[@]}" -shared -fPIC \
		"${ldflags[@]}" || die
}
