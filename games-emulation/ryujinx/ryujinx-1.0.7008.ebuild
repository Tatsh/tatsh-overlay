# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop wrapper xdg

DESCRIPTION="Experimental Nintendo Switch emulator written in C#"
HOMEPAGE="https://ryujinx.org/ https://github.com/Ryujinx/Ryujinx"
# curl 'https://ci.appveyor.com/api/projects/gdkchan/ryujinx/branch/master' | jq -r '.build.jobs[0].jobId'
KEY="sqt2nysaq1itx2a2"
SRC_URI="https://ci.appveyor.com/api/buildjobs/${KEY}/artifacts/${P}-linux_x64.tar.gz"

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
