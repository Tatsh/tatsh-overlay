# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="7.0"
NUGETS="avalonia@11.0.4
	avalonia.angle.windows.natives@2.1.0.2023020321
	avalonia.buildservices@0.0.29
	avalonia.controls.datagrid@11.0.4
	avalonia.desktop@11.0.4
	avalonia.freedesktop@11.0.4
	avalonia.native@11.0.4
	avalonia.reactiveui@11.0.4
	avalonia.remote.protocol@11.0.4
	avalonia.skia@11.0.4
	avalonia.themes.fluent@11.0.4
	avalonia.win32@11.0.4
	avalonia.x11@11.0.4
	avalonia.xaml.behaviors@11.0.2
	avalonia.xaml.interactions@11.0.2
	avalonia.xaml.interactions.custom@11.0.2
	avalonia.xaml.interactions.draganddrop@11.0.2
	avalonia.xaml.interactions.draggable@11.0.2
	avalonia.xaml.interactions.events@11.0.2
	avalonia.xaml.interactions.reactive@11.0.2
	avalonia.xaml.interactions.responsive@11.0.2
	avalonia.xaml.interactivity@11.0.2
	dynamicdata@7.9.5
	dynamicexpresso.core@2.16.1
	ffmpeg.autogen@6.0.0.2
	harfbuzzsharp@2.8.2.3
	harfbuzzsharp.nativeassets.linux@2.8.2.3
	harfbuzzsharp.nativeassets.macos@2.8.2.3
	harfbuzzsharp.nativeassets.webassembly@2.8.2.3
	harfbuzzsharp.nativeassets.win32@2.8.2.3
	microcom.runtime@0.11.0
	microsoft.csharp@4.7.0
	microsoft.win32.systemevents@6.0.0
	mono.posix.netstandard@5.20.1-preview
	protobuf-net@3.2.26
	protobuf-net.core@3.2.26
	reactiveui@18.3.1
	sixlabors.imagesharp@1.0.4
	skiasharp@2.88.3
	skiasharp.nativeassets.linux@2.88.3
	skiasharp.nativeassets.macos@2.88.3
	skiasharp.nativeassets.webassembly@2.88.3
	skiasharp.nativeassets.win32@2.88.3
	splat@14.4.1
	system.collections.immutable@7.0.0
	system.componentmodel.annotations@4.5.0
	system.drawing.common@6.0.0
	system.io.pipelines@6.0.0
	system.numerics.vectors@4.5.0
	system.reactive@5.0.0
	tmds.dbus.protocol@0.15.0"
inherit desktop dotnet-pkg wrapper xdg

DESCRIPTION="Video duplicate finder."
HOMEPAGE="https://github.com/0x90d/videoduplicatefinder"
MY_PN="VideoDuplicateFinder"
MY_PV="3.0.0-preview-${PV:5}"
SHA="76628f303ad8cf15d9a531354d338cd0c1979eb7"
SRC_URI="https://github.com/0x90d/videoduplicatefinder/archive/${SHA}.tar.gz -> ${P}.tar.gz
	${NUGET_URIS}"

DEPEND="media-libs/fontconfig
	sys-libs/zlib"
RDEPEND="${DEPEND}
	media-libs/harfbuzz
	media-video/ffmpeg
	sys-apps/dbus[X]"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${PN}-0001-adjust-paths.patch" )

S="${WORKDIR}/${PN}-${SHA}"

DOTNET_PKG_PROJECTS=( "${S}/VDF.Core/VDF.Core.csproj" "${S}/VDF.GUI/VDF.GUI.csproj" )
DOTNET_RESTORE_EXTRA_ARGS=( "-p:Version=${MY_PV}" )

src_install() {
	newicon -s 48 "VDF.GUI/Assets/icon.png" "${PN}.png"
	make_wrapper "${PN}" "/usr/share/${P}/VDF.GUI" "/usr/share/${P}"
	dosym "${PN}" /usr/bin/vdf
	make_desktop_entry "${PN}" 'Video Duplicate Finder' "${PN}"
	dotnet-pkg_src_install
}
