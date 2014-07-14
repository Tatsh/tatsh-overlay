# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="Grit (only install with git-up)."
HOMEPAGE="https://github.com/mojombo/grit"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/diff-lcs-1.1
	>=dev-ruby/mime-types-1.15
	>=dev-ruby/posix-spawn-0.3.6"

# kate: replace-tabs false
