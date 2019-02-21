# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25 ruby26"
RUBY_FAKEGEM_EXTRADOC="README.md LICENSE.txt"
RUBY_FAKEGEM_BINWRAP=""
MY_HASH="9e925fa203551732ca216a9be4a2e3c883a18923"
RUBY_S="${PN}-${MY_HASH}"
inherit ruby-fakegem

DESCRIPTION="Several file utility methods for copying, moving, removing, etc."
HOMEPAGE="https://github.com/ruby/fileutils"
SRC_URI="https://github.com/ruby/fileutils/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
