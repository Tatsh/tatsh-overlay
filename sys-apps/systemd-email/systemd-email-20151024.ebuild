# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Script to send email for use with systemd."
HOMEPAGE="https://github.com/kylemanna/systemd-utils"
SRC_URI="https://raw.githubusercontent.com/kylemanna/systemd-utils/master/scripts/systemd-email -> ${P}.sh"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_prepare() {
	cp "${DISTDIR}/${P}.sh" systemd-email
	sed -e '1s:.*:#!/usr/bin/env bash:' -i systemd-email
	default
}

src_install() {
	dobin systemd-email
}
