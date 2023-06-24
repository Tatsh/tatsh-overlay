# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_SLOT="7.0"
inherit desktop dotnet-utils wrapper xdg

DESCRIPTION="Video duplicate finder."
HOMEPAGE="https://github.com/0x90d/videoduplicatefinder"
MY_PN="VideoDuplicateFinder"
MY_PV="3.0.0-preview-${PV:5}"
SHA="c7908e7cdf7a6c04ba7172304f35e2f774235b77"
NUGETS="avalonia-11.0.0-preview4
	avalonia.angle.windows.natives-2.1.0.2020091801
	avalonia.controls.datagrid-11.0.0-preview4
	avalonia.desktop-11.0.0-preview4
	avalonia.freedesktop-11.0.0-preview4
	avalonia.native-11.0.0-preview4
	avalonia.reactiveui-11.0.0-preview4
	avalonia.remote.protocol-11.0.0-preview4
	avalonia.skia-11.0.0-preview4
	avalonia.themes.fluent-11.0.0-preview4
	avalonia.win32-11.0.0-preview4
	avalonia.x11-11.0.0-preview4
	avalonia.xaml.behaviors-11.0.0-preview4
	avalonia.xaml.interactions-11.0.0-preview4
	avalonia.xaml.interactivity-11.0.0-preview4
	dynamicdata-7.9.5
	dynamicexpresso.core-2.13.0
	ffmpeg.autogen-6.0.0
	harfbuzzsharp-2.8.2.1-preview.108
	harfbuzzsharp.nativeassets.linux-2.8.2.1-preview.108
	harfbuzzsharp.nativeassets.macos-2.8.2.1-preview.108
	harfbuzzsharp.nativeassets.webassembly-2.8.2.1-preview.108
	harfbuzzsharp.nativeassets.win32-2.8.2.1-preview.108
	jetbrains.annotations-10.3.0
	microcom.runtime-0.11.0
	microsoft.csharp-4.7.0
	microsoft.netcore.platforms-1.0.1
	microsoft.netcore.targets-1.0.1
	microsoft.win32.systemevents-6.0.0
	mono.posix.netstandard-5.20.1-preview
	protobuf-net-3.2.16
	protobuf-net.core-3.2.16
	reactiveui-18.3.1
	sixlabors.imagesharp-1.0.4
	skiasharp-2.88.1
	skiasharp.nativeassets.linux-2.88.1
	skiasharp.nativeassets.macos-2.88.1
	skiasharp.nativeassets.webassembly-2.88.1
	skiasharp.nativeassets.win32-2.88.1
	splat-14.4.1
	system.collections.immutable-7.0.0
	system.componentmodel.annotations-4.5.0
	system.drawing.common-6.0.0
	system.memory-4.5.3
	system.numerics.vectors-4.5.0
	system.reactive-5.0.0
	system.reflection.emit-4.7.0
	system.runtime-4.1.0
	system.runtime.compilerservices.unsafe-4.6.0
	system.security.principal.windows-4.7.0
	system.valuetuple-4.5.0
	tmds.dbus-0.9.0
	microsoft.netcore.app.runtime.linux-x64-7.0.3
	microsoft.aspnetcore.app.runtime.linux-x64-7.0.3
	runtime.any.system.runtime-4.1.0
	system.private.uri-4.0.1
	runtime.unix.system.private.uri-4.0.1
	runtime.native.system-4.0.0"
SRC_URI="https://github.com/0x90d/videoduplicatefinder/archive/${SHA}.tar.gz -> ${P}.tar.gz
	$(nuget_uris)"

DEPEND="media-libs/fontconfig
	sys-libs/zlib"
RDEPEND="${DEPEND}
	media-libs/harfbuzz
	media-video/ffmpeg
	sys-apps/dbus[X]"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${SHA}"

DOTNET_PROJECTS=( "${MY_PN}.sln" )
DOTNET_PV="${MY_PV}"

src_install() {
	newicon -s 48 "VDF.GUI/Assets/icon.png" "${PN}.png"
	mkdir -p "${D}/usr/$(get_libdir)/${PN}" || die
	cp -R "VDF.GUI/bin/Release/net7.0/linux-x64/publish/"* "${D}/usr/$(get_libdir)/${PN}" || die
	make_wrapper "${PN}" "/usr/$(get_libdir)/${PN}/VDF.GUI" "/usr/$(get_libdir)/${PN}"
	dosym "${PN}" /usr/bin/vdf
	make_desktop_entry "${PN}" 'Video Duplicate Finder' "${PN}"
	einstalldocs
}
