# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Updated and improved Kate editor syntax files and code snippets."
HOMEPAGE="https://github.com/zaufi/kate-stuff"
SHA="8c72719fc83954510cac9cc6d015f748cd230b68"
SRC_URI="https://github.com/zaufi/kate-stuff/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${SHA}"

src_install() {
	insinto /usr/share/${PN}
	doins kwin-rules/*
	doins schema/*.kateschema
	insinto /usr/share/org.kde.syntax-highlighting/syntax
	doins syntax/*.xml
	insinto /usr/share/apps/ktexteditor_snippets/data
	doins snippets/*.xml
	einstalldocs
}
