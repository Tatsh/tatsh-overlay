# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0..4} )

inherit distutils-r1 pypi

DESCRIPTION="G2P engine designed for Kokoro models."
HOMEPAGE="https://pypi.org/project/misaki/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+l10n_en l10n_ja l10n_ko l10n_vi l10n_zh"

# shellcheck disable=SC2016
RDEPEND="$(python_gen_cond_dep '
		l10n_en? (
			dev-python/en-core-web-sm[${PYTHON_USEDEP}]
			dev-python/num2words[${PYTHON_USEDEP}]
			dev-python/spacy[${PYTHON_USEDEP}]
			dev-python/phonemizer-fork[${PYTHON_USEDEP}]
			dev-python/espeakng-loader[${PYTHON_USEDEP}]
		)
		l10n_ja? (
			dev-python/fugashi[${PYTHON_USEDEP}]
			dev-python/jaconv[${PYTHON_USEDEP}]
			dev-python/mojimoji[${PYTHON_USEDEP}]
			dev-python/unidic[${PYTHON_USEDEP}]
			dev-python/pyopenjtalk[${PYTHON_USEDEP}]
		)
		l10n_ko? (
			dev-python/jamo[${PYTHON_USEDEP}]
			dev-python/nltk[${PYTHON_USEDEP}]
		)
		l10n_zh? (
			dev-python/jieba[${PYTHON_USEDEP}]
			dev-python/ordered-set[${PYTHON_USEDEP}]
			dev-python/pypinyin[${PYTHON_USEDEP}]
			dev-python/cn2an[${PYTHON_USEDEP}]
			dev-python/pypinyin-dict[${PYTHON_USEDEP}]
		)
		l10n_vi? (
			dev-python/num2words[${PYTHON_USEDEP}]
			dev-python/spacy[${PYTHON_USEDEP}]
			dev-python/underthesea[${PYTHON_USEDEP}]
		)
		dev-python/addict[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}]
	')
	l10n_en? ( dev-python/spacy-curated-transformers[${PYTHON_SINGLE_USEDEP}] )
	l10n_vi? ( dev-python/spacy-curated-transformers[${PYTHON_SINGLE_USEDEP}] )"

distutils_enable_tests pytest
