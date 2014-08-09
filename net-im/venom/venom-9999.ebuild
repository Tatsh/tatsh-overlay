# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="Graphical user interface for Tox written in Vala"
HOMEPAGE="https://github.com/naxuroqa/Venom"
EGIT_REPO_URI="git://github.com/naxuroqa/Venom.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/vala-0.18.1
	>=dev-util/cmake-2.8.7
	>=dev-libs/json-glib-0.14
	>=x11-libs/gtk+-3.4
	>=dev-db/sqlite-3.7"
RDEPEND="${DEPEND}"
