# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop multilib multiprocessing xdg

DESCRIPTION="Experimental Nintendo Switch emulator written in C#"
HOMEPAGE="https://ryujinx.org/ https://github.com/Ryujinx/Ryujinx"
SHA="bd412afb9fdf859643e26d2668874e3dc9cd41df"
MY_PN="R${PN:1}"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://api.nuget.org/v3-flatcontainer/atksharp/3.22.25.128/atksharp.3.22.25.128.nupkg
	https://api.nuget.org/v3-flatcontainer/cairosharp/3.22.25.128/cairosharp.3.22.25.128.nupkg
	https://api.nuget.org/v3-flatcontainer/commandlineparser/2.8.0/commandlineparser.2.8.0.nupkg
	https://api.nuget.org/v3-flatcontainer/concentus/1.1.7/concentus.1.1.7.nupkg
	https://api.nuget.org/v3-flatcontainer/crc32.net/1.2.0/crc32.net.1.2.0.nupkg
	https://api.nuget.org/v3-flatcontainer/discordrichpresence/1.0.175/discordrichpresence.1.0.175.nupkg
	https://api.nuget.org/v3-flatcontainer/ffmpeg.autogen/4.4.1/ffmpeg.autogen.4.4.1.nupkg
	https://api.nuget.org/v3-flatcontainer/gdksharp/3.22.25.128/gdksharp.3.22.25.128.nupkg
	https://api.nuget.org/v3-flatcontainer/giosharp/3.22.25.128/giosharp.3.22.25.128.nupkg
	https://api.nuget.org/v3-flatcontainer/glibsharp/3.22.25.128/glibsharp.3.22.25.128.nupkg
	https://api.nuget.org/v3-flatcontainer/gtksharp.dependencies/1.1.0/gtksharp.dependencies.1.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/gtksharp/3.22.25.128/gtksharp.3.22.25.128.nupkg
	https://api.nuget.org/v3-flatcontainer/libhac/0.15.0/libhac.0.15.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.aspnetcore.app.runtime.linux-x64/6.0.2/microsoft.aspnetcore.app.runtime.linux-x64.6.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.aspnetcore.app.runtime.osx-x64/6.0.2/microsoft.aspnetcore.app.runtime.osx-x64.6.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.aspnetcore.app.runtime.win-x64/6.0.2/microsoft.aspnetcore.app.runtime.win-x64.6.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.codecoverage/16.8.0/microsoft.codecoverage.16.8.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.csharp/4.0.1/microsoft.csharp.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.dotnet.internalabstractions/1.0.0/microsoft.dotnet.internalabstractions.1.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.net.test.sdk/16.8.0/microsoft.net.test.sdk.16.8.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.app.host.osx-x64/6.0.2/microsoft.netcore.app.host.osx-x64.6.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.app.host.win-x64/6.0.2/microsoft.netcore.app.host.win-x64.6.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.app.runtime.linux-x64/6.0.2/microsoft.netcore.app.runtime.linux-x64.6.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.app.runtime.osx-x64/6.0.2/microsoft.netcore.app.runtime.osx-x64.6.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.app.runtime.win-x64/6.0.2/microsoft.netcore.app.runtime.win-x64.6.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.platforms/1.0.1/microsoft.netcore.platforms.1.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.platforms/1.1.0/microsoft.netcore.platforms.1.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.platforms/2.0.0/microsoft.netcore.platforms.2.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.platforms/5.0.0/microsoft.netcore.platforms.5.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.targets/1.0.1/microsoft.netcore.targets.1.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.netcore.targets/1.1.0/microsoft.netcore.targets.1.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.testplatform.objectmodel/16.8.0/microsoft.testplatform.objectmodel.16.8.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.testplatform.testhost/16.8.0/microsoft.testplatform.testhost.16.8.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.win32.primitives/4.0.1/microsoft.win32.primitives.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.win32.primitives/4.3.0/microsoft.win32.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.win32.registry/4.3.0/microsoft.win32.registry.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.win32.registry/4.5.0/microsoft.win32.registry.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.win32.registry/5.0.0/microsoft.win32.registry.5.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.win32.systemevents/6.0.0/microsoft.win32.systemevents.6.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/mono.posix.netstandard/1.0.0/mono.posix.netstandard.1.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/mono.posix.netstandard/5.20.1-preview/mono.posix.netstandard.5.20.1-preview.nupkg
	https://api.nuget.org/v3-flatcontainer/msgpack.cli/1.0.1/msgpack.cli.1.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/netstandard.library/1.6.0/netstandard.library.1.6.0.nupkg
	https://api.nuget.org/v3-flatcontainer/netstandard.library/2.0.0/netstandard.library.2.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/newtonsoft.json/12.0.2/newtonsoft.json.12.0.2.nupkg
	https://api.nuget.org/v3-flatcontainer/newtonsoft.json/9.0.1/newtonsoft.json.9.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/nuget.frameworks/5.0.0/nuget.frameworks.5.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/nunit/3.12.0/nunit.3.12.0.nupkg
	https://api.nuget.org/v3-flatcontainer/nunit3testadapter/3.17.0/nunit3testadapter.3.17.0.nupkg
	https://api.nuget.org/v3-flatcontainer/opentk.core/4.5.0/opentk.core.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/opentk.graphics/4.5.0/opentk.graphics.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/opentk.mathematics/4.5.0/opentk.mathematics.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/opentk.openal/4.5.0/opentk.openal.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/pangosharp/3.22.25.128/pangosharp.3.22.25.128.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.collections/4.3.0/runtime.any.system.collections.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.diagnostics.tools/4.3.0/runtime.any.system.diagnostics.tools.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.diagnostics.tracing/4.3.0/runtime.any.system.diagnostics.tracing.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.globalization.calendars/4.3.0/runtime.any.system.globalization.calendars.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.globalization/4.3.0/runtime.any.system.globalization.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.io/4.3.0/runtime.any.system.io.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.reflection.extensions/4.3.0/runtime.any.system.reflection.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.reflection.primitives/4.3.0/runtime.any.system.reflection.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.reflection/4.3.0/runtime.any.system.reflection.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.resources.resourcemanager/4.3.0/runtime.any.system.resources.resourcemanager.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.runtime.handles/4.3.0/runtime.any.system.runtime.handles.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.runtime.interopservices/4.3.0/runtime.any.system.runtime.interopservices.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.runtime/4.3.0/runtime.any.system.runtime.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.text.encoding.extensions/4.3.0/runtime.any.system.text.encoding.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.text.encoding/4.3.0/runtime.any.system.text.encoding.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.threading.tasks/4.3.0/runtime.any.system.threading.tasks.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.any.system.threading.timer/4.3.0/runtime.any.system.threading.timer.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.native.system.io.compression/4.1.0/runtime.native.system.io.compression.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.native.system.net.http/4.0.1/runtime.native.system.net.http.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.native.system.security.cryptography.openssl/4.3.0/runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.native.system.security.cryptography/4.0.0/runtime.native.system.security.cryptography.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.native.system/4.0.0/runtime.native.system.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.native.system/4.3.0/runtime.native.system.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl/4.3.0/runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.unix.microsoft.win32.primitives/4.3.0/runtime.unix.microsoft.win32.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.unix.system.console/4.3.0/runtime.unix.system.console.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.unix.system.diagnostics.debug/4.3.0/runtime.unix.system.diagnostics.debug.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.unix.system.io.filesystem/4.3.0/runtime.unix.system.io.filesystem.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.unix.system.net.primitives/4.3.0/runtime.unix.system.net.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.unix.system.net.sockets/4.3.0/runtime.unix.system.net.sockets.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.unix.system.private.uri/4.3.0/runtime.unix.system.private.uri.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.unix.system.runtime.extensions/4.3.0/runtime.unix.system.runtime.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.win.microsoft.win32.primitives/4.3.0/runtime.win.microsoft.win32.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.win.system.console/4.3.0/runtime.win.system.console.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.win.system.diagnostics.debug/4.3.0/runtime.win.system.diagnostics.debug.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.win.system.io.filesystem/4.3.0/runtime.win.system.io.filesystem.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.win.system.net.primitives/4.3.0/runtime.win.system.net.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.win.system.net.sockets/4.3.0/runtime.win.system.net.sockets.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/runtime.win.system.runtime.extensions/4.3.0/runtime.win.system.runtime.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/ryujinx.audio.openal.dependencies/1.21.0.1/ryujinx.audio.openal.dependencies.1.21.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/ryujinx.graphics.nvdec.dependencies/4.4.0-build7/ryujinx.graphics.nvdec.dependencies.4.4.0-build7.nupkg
	https://api.nuget.org/v3-flatcontainer/ryujinx.graphics.nvdec.dependencies/4.4.0-build9/ryujinx.graphics.nvdec.dependencies.4.4.0-build9.nupkg
	https://api.nuget.org/v3-flatcontainer/ryujinx.sdl2-cs/2.0.17-build18/ryujinx.sdl2-cs.2.0.17-build18.nupkg
	https://api.nuget.org/v3-flatcontainer/sharpziplib/1.3.3/sharpziplib.1.3.3.nupkg
	https://api.nuget.org/v3-flatcontainer/sixlabors.fonts/1.0.0-beta0013/sixlabors.fonts.1.0.0-beta0013.nupkg
	https://api.nuget.org/v3-flatcontainer/sixlabors.imagesharp.drawing/1.0.0-beta11/sixlabors.imagesharp.drawing.1.0.0-beta11.nupkg
	https://api.nuget.org/v3-flatcontainer/sixlabors.imagesharp/1.0.4/sixlabors.imagesharp.1.0.4.nupkg
	https://api.nuget.org/v3-flatcontainer/system.appcontext/4.1.0/system.appcontext.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.buffers/4.0.0/system.buffers.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.buffers/4.3.0/system.buffers.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.codedom/4.4.0/system.codedom.4.4.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.codedom/6.0.0/system.codedom.6.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.collections.concurrent/4.0.12/system.collections.concurrent.4.0.12.nupkg
	https://api.nuget.org/v3-flatcontainer/system.collections.nongeneric/4.3.0/system.collections.nongeneric.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.collections.specialized/4.3.0/system.collections.specialized.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.collections/4.0.11/system.collections.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.collections/4.3.0/system.collections.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.componentmodel.eventbasedasync/4.3.0/system.componentmodel.eventbasedasync.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.componentmodel.primitives/4.3.0/system.componentmodel.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.componentmodel.typeconverter/4.3.0/system.componentmodel.typeconverter.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.componentmodel/4.3.0/system.componentmodel.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.console/4.0.0/system.console.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.diagnostics.debug/4.0.11/system.diagnostics.debug.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.diagnostics.debug/4.3.0/system.diagnostics.debug.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.diagnostics.diagnosticsource/4.0.0/system.diagnostics.diagnosticsource.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.diagnostics.process/4.3.0/system.diagnostics.process.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.diagnostics.tools/4.0.1/system.diagnostics.tools.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.diagnostics.tracing/4.1.0/system.diagnostics.tracing.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.diagnostics.tracing/4.3.0/system.diagnostics.tracing.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.drawing.common/6.0.0/system.drawing.common.6.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.dynamic.runtime/4.0.11/system.dynamic.runtime.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.globalization.calendars/4.0.1/system.globalization.calendars.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.globalization.extensions/4.0.1/system.globalization.extensions.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.globalization.extensions/4.3.0/system.globalization.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.globalization/4.0.11/system.globalization.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.globalization/4.3.0/system.globalization.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.io.compression.zipfile/4.0.1/system.io.compression.zipfile.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.io.compression/4.1.0/system.io.compression.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.io.filesystem.primitives/4.0.1/system.io.filesystem.primitives.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.io.filesystem.primitives/4.3.0/system.io.filesystem.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.io.filesystem/4.0.1/system.io.filesystem.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.io.filesystem/4.3.0/system.io.filesystem.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.io/4.1.0/system.io.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.io/4.3.0/system.io.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.linq.expressions/4.1.0/system.linq.expressions.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.linq/4.1.0/system.linq.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.linq/4.3.0/system.linq.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.management/6.0.0/system.management.6.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.net.http/4.1.0/system.net.http.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.net.nameresolution/4.3.0/system.net.nameresolution.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.net.primitives/4.0.11/system.net.primitives.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.net.sockets/4.1.0/system.net.sockets.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.numerics.vectors/4.3.0/system.numerics.vectors.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.numerics.vectors/4.5.0/system.numerics.vectors.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.objectmodel/4.0.12/system.objectmodel.4.0.12.nupkg
	https://api.nuget.org/v3-flatcontainer/system.private.uri/4.3.0/system.private.uri.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.emit.ilgeneration/4.0.1/system.reflection.emit.ilgeneration.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.emit.ilgeneration/4.3.0/system.reflection.emit.ilgeneration.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.emit.lightweight/4.0.1/system.reflection.emit.lightweight.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.emit.lightweight/4.3.0/system.reflection.emit.lightweight.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.emit/4.0.1/system.reflection.emit.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.emit/4.3.0/system.reflection.emit.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.extensions/4.0.1/system.reflection.extensions.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.extensions/4.3.0/system.reflection.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.primitives/4.0.1/system.reflection.primitives.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.primitives/4.3.0/system.reflection.primitives.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.typeextensions/4.1.0/system.reflection.typeextensions.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection.typeextensions/4.3.0/system.reflection.typeextensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection/4.1.0/system.reflection.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.reflection/4.3.0/system.reflection.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.resources.resourcemanager/4.0.1/system.resources.resourcemanager.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.resources.resourcemanager/4.3.0/system.resources.resourcemanager.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.compilerservices.unsafe/4.7.0/system.runtime.compilerservices.unsafe.4.7.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.extensions/4.1.0/system.runtime.extensions.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.extensions/4.3.0/system.runtime.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.handles/4.0.1/system.runtime.handles.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.handles/4.3.0/system.runtime.handles.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.interopservices.runtimeinformation/4.0.0/system.runtime.interopservices.runtimeinformation.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.interopservices.runtimeinformation/4.3.0/system.runtime.interopservices.runtimeinformation.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.interopservices/4.1.0/system.runtime.interopservices.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.interopservices/4.3.0/system.runtime.interopservices.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.numerics/4.0.1/system.runtime.numerics.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime.serialization.primitives/4.1.1/system.runtime.serialization.primitives.4.1.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime/4.1.0/system.runtime.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.runtime/4.3.0/system.runtime.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.accesscontrol/4.5.0/system.security.accesscontrol.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.accesscontrol/5.0.0/system.security.accesscontrol.5.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.claims/4.3.0/system.security.claims.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.cryptography.algorithms/4.2.0/system.security.cryptography.algorithms.4.2.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.cryptography.csp/4.0.0/system.security.cryptography.csp.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.cryptography.encoding/4.0.0/system.security.cryptography.encoding.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.cryptography.openssl/4.0.0/system.security.cryptography.openssl.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.cryptography.primitives/4.0.0/system.security.cryptography.primitives.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.cryptography.x509certificates/4.1.0/system.security.cryptography.x509certificates.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.principal.windows/4.3.0/system.security.principal.windows.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.principal.windows/4.5.0/system.security.principal.windows.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.principal.windows/5.0.0/system.security.principal.windows.5.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.principal/4.3.0/system.security.principal.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.text.encoding.extensions/4.0.11/system.text.encoding.extensions.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.text.encoding.extensions/4.3.0/system.text.encoding.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.text.encoding/4.0.11/system.text.encoding.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.text.encoding/4.3.0/system.text.encoding.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.text.regularexpressions/4.1.0/system.text.regularexpressions.4.1.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.text.regularexpressions/4.3.0/system.text.regularexpressions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading.overlapped/4.3.0/system.threading.overlapped.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading.tasks.extensions/4.0.0/system.threading.tasks.extensions.4.0.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading.tasks.extensions/4.3.0/system.threading.tasks.extensions.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading.tasks/4.0.11/system.threading.tasks.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading.tasks/4.3.0/system.threading.tasks.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading.thread/4.3.0/system.threading.thread.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading.threadpool/4.3.0/system.threading.threadpool.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading.timer/4.0.1/system.threading.timer.4.0.1.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading/4.0.11/system.threading.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.threading/4.3.0/system.threading.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.xml.readerwriter/4.0.11/system.xml.readerwriter.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.xml.readerwriter/4.3.0/system.xml.readerwriter.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.xml.xdocument/4.0.11/system.xml.xdocument.4.0.11.nupkg
	https://api.nuget.org/v3-flatcontainer/system.xml.xmldocument/4.3.0/system.xml.xmldocument.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.xml.xpath.xmldocument/4.3.0/system.xml.xpath.xmldocument.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.xml.xpath/4.3.0/system.xml.xpath.4.3.0.nupkg
	https://api.nuget.org/v3-flatcontainer/libhac/0.15.0/libhac.0.15.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.csharp/4.5.0/microsoft.csharp.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.identitymodel.jsonwebtokens/6.15.0/microsoft.identitymodel.jsonwebtokens.6.15.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.identitymodel.logging/6.15.0/microsoft.identitymodel.logging.6.15.0.nupkg
	https://api.nuget.org/v3-flatcontainer/microsoft.identitymodel.tokens/6.15.0/microsoft.identitymodel.tokens.6.15.0.nupkg
	https://api.nuget.org/v3-flatcontainer/spb/0.0.4-build17/spb.0.0.4-build17.nupkg
	https://api.nuget.org/v3-flatcontainer/system.identitymodel.tokens.jwt/6.15.0/system.identitymodel.tokens.jwt.6.15.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.cryptography.cng/4.5.0/system.security.cryptography.cng.4.5.0.nupkg
	https://api.nuget.org/v3-flatcontainer/system.security.cryptography.cng/4.2.0/system.security.cryptography.cng.4.2.0.nupkg"

NET_SLOT="6.0"
BDEPEND="virtual/dotnet-sdk:${NET_SLOT}"
DEPEND="app-crypt/mit-krb5
	sys-libs/zlib"
# FIXME Make SoundIO and OpenAL optional
RDEPEND="${DEPEND}
	dev-libs/icu
	dev-libs/openssl
	media-libs/libsdl2
	media-libs/libsoundio
	media-libs/openal
	media-video/ffmpeg
	x11-libs/gtk+:3
	virtual/opengl"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"
PATCHES=( "${FILESDIR}/${PN}-no-updates.patch" )

S="${WORKDIR}/${MY_PN}-${SHA}"

src_unpack() {
	local archive
	for archive in ${A}; do
		case "${archive}" in
			*.nupkg)
				;;
			*)
				unpack ${archive}
				;;
		esac
	done
}

src_prepare() {
	default
	export \
		DOTNET_CLI_TELEMETRY_OPTOUT=1 \
		DOTNET_NOLOGO=1 \
		MSBUILDDISABLENODEREUSE=1 \
		NO_COLOR=1
	dotnet restore \
		-maxcpucount:$(makeopts_jobs) \
		--runtime linux-x64 \
		--source "${DISTDIR}" || die
}

src_compile() {
	addpredict /opt/dotnet-sdk-bin-${NET_SLOT}/metadata
	export \
		DOTNET_CLI_TELEMETRY_OPTOUT=1 \
		DOTNET_NOLOGO=1 \
		MSBUILDDISABLENODEREUSE=1 \
		NO_COLOR=1
	dotnet publish \
		-maxcpucount:$(makeopts_jobs) \
		--nologo \
		--no-restore \
		--configuration Release \
		--runtime linux-x64 \
		"-p:Version=${PV}" \
		-p:DebugType=embedded \
		--self-contained || die
}

src_install() {
	cd "${MY_PN}/bin/Release/net${NET_SLOT}/linux-x64/publish" || die
	dobin "${MY_PN}"
	newicon -s 32 "${FILESDIR}/${PN}-logo.png" "${PN}.png"
	make_desktop_entry "/usr/bin/${MY_PN}" "${MY_PN}" "${PN}"
	einstalldocs
}
