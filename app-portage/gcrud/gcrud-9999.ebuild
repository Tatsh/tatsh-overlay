# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake git-r3

DESCRIPTION="Clean up cruft on your file system."
HOMEPAGE="https://tatsh.github.io/gcrud/"
EGIT_REPO_URI="https://github.com/Tatsh/gcrud.git"

LICENSE="MIT"
SLOT="0"

DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}"
