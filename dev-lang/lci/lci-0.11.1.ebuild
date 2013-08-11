# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="LOLCODE interpreter written in C and is designed to be correct, portable, fast, and precisely documented."
HOMEPAGE="http://lolcode.org/"
SRC_URI="https://github.com/justinmeza/lci/archive/v0.11.1.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
