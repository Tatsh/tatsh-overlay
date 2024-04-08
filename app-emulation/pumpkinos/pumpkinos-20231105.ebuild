# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION=""
HOMEPAGE="https://github.com/migueletto/PumpkinOS https://pmig96.wordpress.com/category/palmos/"
SHA="6c928410022649e76d43338833c8da4481ee5d12"
MY_PN="PumpkinOS"
SRC_URI="https://github.com/migueletto/${MY_PN}/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/libsdl2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${SHA}"

PATCHES=( "${FILESDIR}/${PN}-0001-copy-vfs.patch" )

src_prepare() {
	sed -re "s/CFLAGS=/CFLAGS=${CFLAGS} /" -i src/common.mak || die
	default
}

src_compile() {
	local DIR ROOT dir
	pushd src
	DIR=$(pwd -P)
	ROOT="${DIR}/.."
	for dir in bin lib tools vfs/app_card/PALM/Programs vfs/app_install vfs/app_storage registry; do
		if [ ! -d "${ROOT}/${dir}" ]; then
			mkdir -p "${ROOT}/${dir}" || die
		fi
	done
	for dir in pilrc prcbuild; do
		if [ -d "$dir" ]; then
			pushd "$dir" && emake "ROOT=${ROOT}" BITS=64
			popd || die
		fi
	done
	for dir in libpit lua liblsdl2 libpumpkin libos libshell linux BOOT Launcher Preferences Command Edit LuaSyntax MemoPad AddressBook ToDoList DateBook; do
		if [ -d "$dir" ]; then
			pushd "$dir" && emake "ROOT=${ROOT}" OSNAME=GNU/Linux BITS=64
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
