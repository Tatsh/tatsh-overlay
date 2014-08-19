# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3

DESCRIPTION="Privacy-oriented on-line communication library"
HOMEPAGE="https://tox.im/"
EGIT_REPO_URI="git://github.com/irungentoo/ProjectTox-Core.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libsodium-0.5.0"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf || die "eautoreconf failed"
}
