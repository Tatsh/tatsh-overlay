# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 pypi

DESCRIPTION="Legacy registered functions for spaCy backwards compatibility"
HOMEPAGE="https://github.com/explosion/spacy-legacy"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

S="${WORKDIR}/${PN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# The tests import spacy, which depends on this package.
BDEPEND="test? ( dev-python/spacy[${PYTHON_USEDEP}] )"

EPYTEST_DESELECT=(
	# CharacterEmbed in current thinc takes different arguments than the v1 layer expects.
	"spacy_legacy/tests/pipeline/test_tok2vec.py::test_tok2vec[8-CharacterEmbed_v1-embed_config2-MaxoutWindowEncoder_v1-encode_config2]"
	"spacy_legacy/tests/pipeline/test_tok2vec.py::test_tok2vec[8-CharacterEmbed_v1-embed_config3-MishWindowEncoder_v1-encode_config3]"
	# Needs wandb.
	spacy_legacy/tests/test_logger.py::test_logger
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
