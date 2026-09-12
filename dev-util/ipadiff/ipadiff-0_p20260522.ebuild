# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

# Upstream has never tagged a release, so this is a snapshot of the default
# branch.
MY_COMMIT="fda9b001d9b38122e544ecfa5ad4e53c97b694f8"

DESCRIPTION="Diff two iOS .ipa bundles."
HOMEPAGE="https://github.com/Xplo8E/ipadiff"
SRC_URI="https://github.com/Xplo8E/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	ego build -o "${PN}" ./cmd/"${PN}"
}

src_install() {
	dobin "${PN}"
	einstalldocs
}

pkg_postinst() {
	elog "The optional hermes-diff sidecar, which diffs Hermes bytecode inside"
	elog "React Native bundles, is not packaged: it is a Rust tool that depends"
	elog "on a crate published only as a git revision. ${PN} looks for it on"
	elog "PATH and simply skips Hermes diffing when it is absent."
}
