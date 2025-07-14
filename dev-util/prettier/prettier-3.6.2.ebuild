# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="Prettier is an opinionated code formatter"
HOMEPAGE="https://prettier.io"
YARN_PKGS=(
	@taplo/core-0.2.0
	@taplo/lib-0.5.0
	prettier-3.4.1
	prettier-3.6.2
	prettier-plugin-ini-1.3.0
	prettier-plugin-sort-json-4.1.1
	prettier-plugin-toml-2.0.6
)
yarn_set_globals
SRC_URI="${YARN_SRC_URI}"

LICENSE="Apache-2 MIT"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	yarn_src_install
	fperms 0755 "/usr/$(get_libdir)/${PN}/node_modules/prettier/bin/${PN}.cjs"
	dosym "../$(get_libdir)/${PN}/node_modules/prettier/bin/${PN}.cjs" "/usr/bin/${PN}"
}
