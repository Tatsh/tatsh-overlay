# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Prevents you from committing sensitive info to a git repository."
HOMEPAGE="https://github.com/awslabs/git-secrets"
SHA="7d6b970cbd3c216353cb22b383b70c150140662e"
SRC_URI="https://github.com/awslabs/git-secrets/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-vcs/git-2.10.2"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/docutils"

PATCHES=(
	"${FILESDIR}"/git-secrets-1.3.0-rst2man.patch
)

src_compile () {
	emake man
}

src_install () {
	emake DESTDIR="${D}" PREFIX=/usr install
	doman "${PN}.1"
	einstalldocs
}
