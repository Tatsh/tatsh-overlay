# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0..4} )

inherit distutils-r1 pypi

DESCRIPTION="G2P engine designed for Kokoro models."
HOMEPAGE="https://pypi.org/project/misaki/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+l10n_en"
IUSE_IL10N=( ja ko zh vi he )
for lang in "${IUSE_IL10N[@]}"; do
	IUSE="${IUSE} l10n_${lang}"
done

RDEPEND="l10n_en? (
		dev-python/num2words[${PYTHON_USEDEP}]
		dev-python/spacy[${PYTHON_USEDEP}]
		dev-python/spacy-curated-transformers[${PYTHON_USEDEP}]
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
		dev-python/spacy-curated-transformers[${PYTHON_USEDEP}]
		dev-python/underthesea[${PYTHON_USEDEP}]
	)
	l10n_he? ( dev-python/mishkal-hebrew[${PYTHON_USEDEP}] )
	dev-python/addict[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
