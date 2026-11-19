# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DOTNET_PKG_COMPAT=10.0
NUGETS="avalonia.angle.windows.natives@2.1.27548.20260419
	avalonia.buildservices@11.3.2
	avalonia.desktop@12.1.0
	avalonia.fonts.inter@12.1.0
	avalonia.freedesktop.atspi@12.1.0
	avalonia.freedesktop@12.1.0
	avalonia.harfbuzz@12.1.0
	avalonia.native@12.1.0
	avalonia.remote.protocol@12.1.0
	avalonia.skia@12.1.0
	avalonia.themes.fluent@12.1.0
	avalonia.win32@12.1.0
	avalonia.x11@12.1.0
	avalonia@12.1.0
	ffmpeg.autogen@7.1.1
	harfbuzzsharp.nativeassets.linux@8.3.1.3
	harfbuzzsharp.nativeassets.macos@8.3.1.3
	harfbuzzsharp.nativeassets.webassembly@8.3.1.3
	harfbuzzsharp.nativeassets.win32@8.3.1.3
	harfbuzzsharp@8.3.1.3
	iced@1.21.0
	microcom.runtime@0.11.6
	microsoft.build.framework@17.14.8
	microsoft.codeanalysis.analyzers@3.11.0
	microsoft.codeanalysis.analyzers@3.3.4
	microsoft.codeanalysis.common@4.12.0
	microsoft.codeanalysis.csharp@4.12.0
	microsoft.codecoverage@17.14.1
	microsoft.dotnet.platformabstractions@3.1.6
	microsoft.extensions.dependencymodel@9.0.9
	microsoft.net.test.sdk@17.14.1
	microsoft.netcore.platforms@1.1.0
	microsoft.testplatform.objectmodel@17.14.1
	microsoft.testplatform.testhost@17.14.1
	microsoft.win32.registry@5.0.0
	netstandard.library@1.6.1
	netstandard.library@2.0.3
	newtonsoft.json@13.0.3
	nlayer@1.14.0
	ppy.sdl3-cs@2026.629.0
	silk.net.core@2.23.0
	silk.net.vulkan.extensions.ext@2.23.0
	silk.net.vulkan.extensions.khr@2.23.0
	silk.net.vulkan@2.23.0
	skiasharp.nativeassets.linux@3.119.4
	skiasharp.nativeassets.macos@3.119.4
	skiasharp.nativeassets.webassembly@3.119.4
	skiasharp.nativeassets.win32@3.119.4
	skiasharp@3.119.4
	system.buffers@4.5.1
	system.buffers@4.6.0
	system.collections.immutable@8.0.0
	system.diagnostics.diagnosticsource@9.0.0
	system.io.hashing@10.0.0
	system.memory@4.5.4
	system.memory@4.5.5
	system.memory@4.6.0
	system.numerics.vectors@4.5.0
	system.numerics.vectors@4.6.0
	system.reflection.metadata@8.0.0
	system.runtime.compilerservices.unsafe@4.5.3
	system.runtime.compilerservices.unsafe@6.0.0
	system.runtime.compilerservices.unsafe@6.1.0
	system.security.accesscontrol@5.0.0
	system.security.principal.windows@5.0.0
	system.text.encoding.codepages@7.0.0
	system.threading.tasks.extensions@4.5.4
	tmds.dbus.protocol@0.94.1
	xunit.abstractions@2.0.3
	xunit.analyzers@1.18.0
	xunit.assert@2.9.3
	xunit.core@2.9.3
	xunit.extensibility.core@2.9.3
	xunit.extensibility.execution@2.9.3
	xunit.runner.visualstudio@3.1.1
	xunit@2.9.3
	zstdsharp.port@0.8.5
"

inherit desktop dotnet-pkg xdg

# Upstream tags each release with a codename.
MY_PV="${PV}-pulse"

DESCRIPTION="Experimental PlayStation 5 emulator written in C#"
HOMEPAGE="https://sharpemu.app/ https://github.com/sharpemu/sharpemu"
SRC_URI="https://github.com/sharpemu/sharpemu/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	${NUGET_URIS}"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-2+ Apache-2.0 MIT"
# Licenses of the NuGet dependencies.
LICENSE+=" BSD LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="media-libs/fontconfig
	media-libs/freetype
	media-libs/vulkan-loader
	media-video/ffmpeg-compat:7
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXrandr"

DOTNET_PKG_PROJECTS=( src/SharpEmu.CLI/SharpEmu.CLI.csproj )
PATCHES=( "${FILESDIR}/${PN}-system-paths.patch" )

src_prepare() {
	sed -e "s|Path.Combine(AppContext.BaseDirectory, \"plugins\")|\"${EPREFIX}/usr/lib/ffmpeg7/$(get_libdir)\"|" \
		-i src/SharpEmu.Libs/Media/FfmpegRuntime.cs src/SharpEmu.Libs/Codec/Videodec2Decoder.cs || die
	dotnet-pkg_src_prepare
}

src_compile() {
	export AVALONIA_TELEMETRY_OPTOUT=1
	dotnet-pkg_src_compile
}

src_test() {
	# The Metal shader compiler tests are macOS-only.
	local project
	for project in tests/SharpEmu.{Libs,ShaderCompiler,SourceGenerators}.Tests; do
		dotnet-pkg-base_restore "${project}"
		dotnet-pkg-base_test --runtime "${DOTNET_PKG_RUNTIME}" "${project}"
	done
}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/SharpEmu" "${PN}"
	newicon -s 256 assets/images/logo.png "${PN}.png"
	make_desktop_entry "${PN}" SharpEmu "${PN}" "Game;Emulator"
	einstalldocs
}
