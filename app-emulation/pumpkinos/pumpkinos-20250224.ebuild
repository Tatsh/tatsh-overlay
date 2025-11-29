# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="PumpkinOS is a re-implementation of PalmOS."
HOMEPAGE="https://github.com/migueletto/PumpkinOS https://pmig96.wordpress.com/category/palmos/"
SHA="c892e282d154d2598fc5c6185403ca1b11132bd9"
MY_PN="PumpkinOS"
SRC_URI="https://github.com/migueletto/${MY_PN}/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"

S="${WORKDIR}/${MY_PN}-${SHA}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/libsdl2"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-0001-copy-vfs.patch" )

src_prepare() {
	sed -re "s/CFLAGS=/CFLAGS=${CFLAGS} /" -i src/common.mak || die
	default
}

src_compile() {
	local DIR _ROOT dir
	pushd src || die
	DIR=$(pwd -P)
	_ROOT="${DIR}/.."
	for dir in bin lib tools vfs/app_card/PALM/Programs vfs/app_install vfs/app_storage registry; do
		if [ ! -d "${_ROOT}/${dir}" ]; then
			mkdir -p "${_ROOT}/${dir}" || die
		fi
	done
	for dir in pilrc prcbuild; do
		if [ -d "$dir" ]; then
			pushd "$dir" && emake "ROOT=${_ROOT}" BITS=64
			popd || die
		fi
	done
	for dir in libpit lua liblsdl2 libpumpkin libos libshell linux BOOT Launcher Preferences Command Edit LuaSyntax MemoPad AddressBook ToDoList DateBook; do
		if [ -d "$dir" ]; then
			pushd "$dir" && emake "ROOT=${_ROOT}" OSNAME=GNU/Linux BITS=64
			popd || die
		fi
	done
	popd || die
}

src_install() {
	local libdir
	libdir="${EPREFIX}/usr/$(get_libdir)/${MY_PN}"
	insinto "/usr/$(get_libdir)/${MY_PN}"
	doins -r script/*_linux.*
	cp pumpkin bin/*.so "${D}/usr/$(get_libdir)/${MY_PN}"
	cat > pumpkin-bin <<EOF
#!/usr/bin/env bash
export LD_LIBRARY_PATH="${libdir}"
storage_dir="\${HOME}/.local/share/${MY_PN}"
mkdir -p "\$storage_dir"
if ! [ -d "\${storage_dir}/vfs" ]; then
	cp -rf "${libdir}/vfs" "\${storage_dir}"
fi
mkdir -p "\${storage_dir}/vfs/app_storage" "\${storage_dir}/registry" "\${storage_dir}/log"
cd "\$storage_dir" || exit 1
"${libdir}/pumpkin" -d 1 -s "${libdir}/libscriptlua.so" "${libdir}/pumpkin_linux.lua"
EOF
	newbin ./pumpkin-bin pumpkin
	insinto "/usr/$(get_libdir)/${MY_PN}/vfs"
	doins -r vfs/*
	make_desktop_entry pumpkin "${MY_PN}"
	einstalldocs
}
