# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils cmake-utils subversion

EAPI=3
ESVN_REPO_URI="http://llvm.org/svn/llvm-project/compiler-rt/trunk"
DESCRIPTION="A simple library that provides an implementation of the low-level target-specific hooks required by code generation and other runtime components."
HOMEPAGE="http://compiler-rt.llvm.org/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
}
