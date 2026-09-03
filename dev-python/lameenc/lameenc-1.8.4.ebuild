# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python bindings for the LAME MP3 encoder."
HOMEPAGE="https://pypi.org/project/lameenc/ https://github.com/chrisstaite/lameenc"
# PyPI publishes wheels only, so the sources come from the git tag.
SRC_URI="https://github.com/chrisstaite/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"
DEPEND="media-sound/lame"
RDEPEND="${DEPEND}"

# There is no git checkout to read the version from.
export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_prepare_all() {
	# Upstream's CMakeLists.txt downloads LAME 3.100 and links libmp3lame.a into
	# the extension. Link the system shared library instead and ignore cmake.
	# Without --libdir/--incdir setup.py already leaves extra_objects and
	# include_dirs empty, so only the bail-out and the library name need changing.
	sed -i -e 's/^        sys\.exit(1)$/        pass/' \
		-e "s/libraries=\['libmp3lame'\] if sys\.platform == 'win32' else \[\]/libraries=['mp3lame']/" \
		setup.py || die
	# media-sound/lame installs its header into a lame/ subdirectory.
	sed -i 's|#include <lame\.h>|#include <lame/lame.h>|' lameenc.c || die
	distutils-r1_python_prepare_all
}
