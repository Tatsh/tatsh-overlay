# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUBY_FAKEGEM_GEMSPEC="${PN//-/_}.gemspec"
USE_RUBY="ruby31 ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Download an entire website from the Wayback Machine"
HOMEPAGE="https://github.com/ShiftaDeband/wayback-machine-downloader"
SHA="b81381396827521b4a1fa88b40fc4c27b3ec31e2"
SRC_URI="https://github.com/ShiftaDeband/wayback-machine-downloader/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"
RUBY_S="${PN}-${SHA}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PROPERTIES="test_network"
RESTRICT="test"
