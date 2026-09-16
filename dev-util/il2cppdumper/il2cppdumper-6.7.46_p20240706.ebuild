# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=9.0
NUGETS="mono.cecil@0.11.4"

inherit dotnet-pkg

MY_PN="Il2CppDumper"
# One commit past v6.7.46, and that commit is the one that replaced the end of
# life net7.0 target with net8.0. Nothing else changed.
MY_COMMIT="4741d46ba9cd6159c5d853eb9d6fc48b4bfa2b1a"

DESCRIPTION="Unity il2cpp reverse engineering tool."
HOMEPAGE="https://github.com/Perfare/Il2CppDumper"
SRC_URI="https://github.com/Perfare/${MY_PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz
	${NUGET_URIS}"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOTNET_PKG_PROJECTS=( "${S}/${MY_PN}/${MY_PN}.csproj" )

PATCHES=( "${FILESDIR}/${PN}-unity6.patch" )

src_prepare() {
	# Upstream targets net6.0 and net8.0, both older than the SDK here, and
	# the launcher runs the result against that SDK's runtime. Building for
	# either of them produces something that runtime declines to start, so
	# build for the framework it does provide.
	sed -i -e "s|<TargetFrameworks>.*</TargetFrameworks>|<TargetFramework>net${DOTNET_PKG_COMPAT}</TargetFramework>|" \
		"${MY_PN}/${MY_PN}.csproj" || die
	grep -q "<TargetFramework>net${DOTNET_PKG_COMPAT}</TargetFramework>" \
		"${MY_PN}/${MY_PN}.csproj" || die "failed to retarget the project"

	dotnet-pkg_src_prepare
}

src_install() {
	dotnet-pkg_src_install

	# The executable is named after the project rather than the package, so
	# dotnet-pkg_src_install does not recognise it and writes no launcher.
	dotnet-pkg-base_dolauncher "/usr/share/${P}/${MY_PN}" "${PN}"
}
