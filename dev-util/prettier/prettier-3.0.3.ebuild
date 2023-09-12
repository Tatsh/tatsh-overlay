# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit yarn

DESCRIPTION="Prettier is an opinionated code formatter"
HOMEPAGE="https://prettier.io"
YARN_PKGS=(
	"${P}"
	@chevrotain/cst-dts-gen-11.0.3
	@chevrotain/gast-11.0.3
	@chevrotain/regexp-to-ast-11.0.3
	@chevrotain/types-11.0.3
	@chevrotain/utils-11.0.3
	@toml-tools/lexer-1.0.0
	@toml-tools/parser-1.0.0
	chevrotain-11.0.3
	lodash-es-4.17.21
	prettier-plugin-ini-1.1.0
	prettier-plugin-sort-json-3.0.1
	prettier-plugin-toml-1.0.0
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
