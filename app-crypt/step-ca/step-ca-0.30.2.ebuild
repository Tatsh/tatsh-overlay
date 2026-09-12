# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PN="certificates"

DESCRIPTION="Private certificate authority and ACME server."
HOMEPAGE="https://smallstep.com/certificates https://github.com/smallstep/certificates"
SRC_URI="https://github.com/smallstep/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.0"
# go-piv uses cgo against libpcsclite for the YubiKey PIV key manager.
DEPEND="sys-apps/pcsc-lite"
RDEPEND="${DEPEND}"

src_compile() {
	# BuildTime is left empty so the build stays reproducible.
	ego build -o "${PN}" \
		-ldflags "-X main.Version=${PV} -X main.BuildTime=" \
		./cmd/"${PN}"
}

src_install() {
	dobin "${PN}"
	einstalldocs
}

pkg_postinst() {
	elog "Initialise a new CA with 'step ca init', which is provided by the"
	elog "separate step CLI. No service file is installed; run ${PN} from your"
	elog "own service definition."
}
