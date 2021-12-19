# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="cifsd kernel server userspace utilities"
HOMEPAGE="https://github.com/cifsd-team/ksmbd-tools"
SRC_URI="https://github.com/cifsd-team/${PN}/releases/download/${PV}/ksmbd-tools-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kerberos"

DEPEND="dev-libs/glib:2
	dev-libs/libnl:3
	kerberos? ( app-crypt/mit-krb5 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable kerberos krb5)
}
