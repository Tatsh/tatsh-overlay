# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_BINWRAP=""
MY_SHA="ec0c229e788e25d5008274dae3f9755de032754f"
RUBY_S="${PN}-${MY_SHA}"
inherit ruby-fakegem

DESCRIPTION="Several file utility methods for copying, moving, removing, etc."
HOMEPAGE="https://github.com/ruby/fileutils"
SRC_URI="https://github.com/ruby/fileutils/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
