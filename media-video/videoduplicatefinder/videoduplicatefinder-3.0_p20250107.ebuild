# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="9.0"
NUGETS="actiprosoftware.controls.avalonia.themes.datagrid@25.1.0
	actiprosoftware.controls.avalonia@25.1.0
	avalonia.angle.windows.natives@2.1.22045.20230930
	avalonia.buildservices@0.0.29
	avalonia.controls.datagrid@11.2.3
	avalonia.desktop@11.2.3
	avalonia.freedesktop@11.2.3
	avalonia.native@11.2.3
	avalonia.reactiveui@11.2.3
	avalonia.remote.protocol@11.2.3
	avalonia.skia@11.2.3
	avalonia.themes.fluent@11.2.3
	avalonia.win32@11.2.3
	avalonia.x11@11.2.3
	avalonia.xaml.behaviors@11.2.0.1
	avalonia.xaml.interactions.custom@11.2.0.1
	avalonia.xaml.interactions.draganddrop@11.2.0.1
	avalonia.xaml.interactions.draggable@11.2.0.1
	avalonia.xaml.interactions.events@11.2.0.1
	avalonia.xaml.interactions.reactive@11.0.2
	avalonia.xaml.interactions.responsive@11.2.0.1
	avalonia.xaml.interactions@11.2.0.1
	avalonia.xaml.interactivity@11.2.0.1
	avalonia@11.2.3
	dynamicdata@8.4.1
	dynamicexpresso.core@2.17.2
	ffmpeg.autogen@7.0.0
	harfbuzzsharp.nativeassets.linux@7.3.0.3
	harfbuzzsharp.nativeassets.macos@7.3.0.3
	harfbuzzsharp.nativeassets.webassembly@7.3.0.3
	harfbuzzsharp.nativeassets.win32@7.3.0.3
	harfbuzzsharp@7.3.0.3
	microcom.runtime@0.11.0
	microsoft.csharp@4.7.0
	microsoft.win32.systemevents@6.0.0
	mono.posix.netstandard@5.20.1-preview
	protobuf-net.core@3.2.45
	protobuf-net@3.2.45
	reactiveui@20.1.1
	sixlabors.imagesharp@3.1.6
	skiasharp.nativeassets.linux@2.88.9
	skiasharp.nativeassets.macos@2.88.9
	skiasharp.nativeassets.webassembly@2.88.9
	skiasharp.nativeassets.win32@2.88.9
	skiasharp@2.88.9
	splat@15.1.1
	system.collections.immutable@7.0.0
	system.componentmodel.annotations@5.0.0
	system.drawing.common@6.0.0
	system.io.pipelines@8.0.0
	system.numerics.vectors@4.5.0
	system.reactive@6.0.1
	tmds.dbus.protocol@0.20.0"
inherit desktop dotnet-pkg wrapper xdg

DESCRIPTION="Video duplicate finder."
HOMEPAGE="https://github.com/0x90d/videoduplicatefinder"
MY_PN="VideoDuplicateFinder"
MY_PV="3.0.0-preview-${PV:5}"
SHA="225a255809e2b63ed589fe364588009bacc231ca"
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
