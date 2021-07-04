# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop wrapper

DESCRIPTION="Experimental Nintendo Switch emulator written in C#"
HOMEPAGE="https://ryujinx.org/ https://github.com/Ryujinx/Ryujinx"
SHA="94cc365b635b0c42f6443af724ff0cdcb7ab00a3"
SRC_URI="https://ci.appveyor.com/api/buildjobs/9u4mjkb942cpykha/artifacts/${P}-linux_x64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/publish"

MY_PN="R${PN:1}"
QA_PREBUILT="/opt/${PN}/*.so /opt/${PN}/${MY_PN}"

src_install() {
	insinto "/opt/${PN}"
	doins ./*.ini ./*.txt ./*.md ./*.config
	make_wrapper "${MY_PN}" "/opt/${PN}/${MY_PN}" "/opt/${PN}" "/opt/${PN}" /opt/bin/
	newicon -s 32 "${FILESDIR}/${PN}-logo.png" "${PN}.png"
	make_desktop_entry "/opt/bin/${MY_PN}" "${MY_PN}" "${PN}"
	exeinto "/opt/${PN}"
	doexe "${MY_PN}"
	insopts -m755
	doins *.so
}
