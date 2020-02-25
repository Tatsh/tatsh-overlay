# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Tools for Xirvik servers."
HOMEPAGE="https://github.com/Tatsh/xirvik-tools"
SRC_URI="https://github.com/Tatsh/xirvik-tools/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/argcomplete
dev-python/cached-property
dev-python/lockfile
dev-python/paramiko
dev-python/requests
dev-python/requests-futures
dev-python/unidecode
dev-python/humanize
dev-python/importlib_metadata
dev-python/typing-extensions
dev-python/benc"
RDEPEND="${DEPEND}"
BDEPEND=""

DISTUTILS_USE_SETUPTOOLS="rdepend"
