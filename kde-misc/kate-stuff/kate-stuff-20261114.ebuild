# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Updated and improved Kate editor syntax files and code snippets"
HOMEPAGE="https://github.com/zaufi/kate-stuff"
SHA="f1bdda9e1d37c8c249798e5c5707f503dc797ab0"
SRC_URI="https://github.com/zaufi/kate-stuff/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

src_install() {
	insinto "/usr/share/${PN}"
	doins kwin-rules/*
	doins schema/*.kateschema
	insinto /usr/share/org.kde.syntax-highlighting/syntax
	doins syntax/*.xml
	insinto /usr/share/apps/ktexteditor_snippets/data
	doins snippets/*.xml
	einstalldocs
}
