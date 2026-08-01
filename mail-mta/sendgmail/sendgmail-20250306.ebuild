# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Tool that uses Gmail in order to mimic sendmail for 'git send-email'."
HOMEPAGE="https://github.com/google/gmail-oauth2-tools/tree/master/go/sendgmail"
SHA="85c6b4f07e637683cc5e0ec6a66ce8e4397a4b18"
SRC_URI="https://github.com/google/gmail-oauth2-tools/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"
S="${WORKDIR}/gmail-oauth2-tools-${SHA}/go/${PN}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	go build -o "${PN}" || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
