# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils eutils git-r3

DESCRIPTION="Spec for 'standard markdown', with matching C and javascript implementations."
HOMEPAGE="https://github.com/jgm/CommonMark"
EGIT_REPO_URI="git://github.com/jgm/CommonMark.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/re2c-0.13.5-r1
	>=dev-util/cmake-2.8.12.2"
RDEPEND="${DEPEND}"
