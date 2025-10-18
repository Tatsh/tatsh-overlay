# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="FastAPI wrapper for Kokoro-82M text-to-speech model"
HOMEPAGE="https://github.com/remsky/Kokoro-FastAPI"
SRC_URI="https://github.com/remsky/Kokoro-FastAPI/archive/v${PV}.tar.gz -> ${P}.tar.gz"
IUSE="standalone test"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/aiofiles-23.2.1[${PYTHON_USEDEP}]
	>=dev-python/av-14.2.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
	dev-python/espeakng-loader[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	>=dev-python/inflect-7.5.0[${PYTHON_USEDEP}]
	dev-python/kokoro[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.10.0[${PYTHON_USEDEP}]
	dev-python/misaki[en,ja,ko,zh,${PYTHON_USEDEP}]
	dev-python/munch[${PYTHON_USEDEP}]
	>=dev-python/mutagen-1.47.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/openai-1.59.6[${PYTHON_USEDEP}]
	>=dev-python/phonemizer-fork-3.3.2[${PYTHON_USEDEP}]
	>=dev-python/psutil-6.1.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.10.4[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/pydub-0.25.1[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/soundfile[${PYTHON_USEDEP}]
	dev-python/spacy[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	>=dev-python/text2num-2.5.1[${PYTHON_USEDEP}]
	dev-python/tiktoken[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
  >=sci-ml/pytorch-2.8.0[${PYTHON_USEDEP}]
	standalone? ( dev-python/uvicorn[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="test? (
		dev-python/httpx[${PYTHON_USEDEP}]
		>=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		>=dev-python/tomli-2.0.1[${PYTHON_USEDEP}]
)"


S="${WORKDIR}/Kokoro-FastAPI-${PV}"

EPYTEST_PLUGINS=( pytest-{asyncio,cov} )
distutils_enable_tests pytest
