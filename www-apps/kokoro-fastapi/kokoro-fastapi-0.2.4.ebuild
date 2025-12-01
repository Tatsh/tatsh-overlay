# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )
inherit distutils-r1 systemd

DESCRIPTION="FastAPI wrapper for Kokoro-82M text-to-speech model"
HOMEPAGE="https://github.com/remsky/Kokoro-FastAPI"
SRC_URI="https://github.com/remsky/Kokoro-FastAPI/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/remsky/Kokoro-FastAPI/releases/download/v0.1.4/kokoro-v1_0.pth -> ${P}-kokoro-v1_0.pth
  https://github.com/remsky/Kokoro-FastAPI/releases/download/v0.1.4/config.json -> ${P}-kokoro-v1_0-config.json"
S="${WORKDIR}/Kokoro-FastAPI-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="standalone test"

# shellcheck disable=SC2016
RDEPEND="standalone? (
		acct-group/kokoro-fastapi
		acct-user/kokoro-fastapi
	)
	$(python_gen_cond_dep '
		>=dev-python/aiofiles-23.2.1[${PYTHON_USEDEP}]
		>=dev-python/av-14.2.0[${PYTHON_USEDEP}]
		>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
		dev-python/espeakng-loader[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		>=dev-python/inflect-7.5.0[${PYTHON_USEDEP}]
		dev-python/loguru[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.10.0[${PYTHON_USEDEP}]
		dev-python/munch[${PYTHON_USEDEP}]
		>=media-libs/mutagen-1.47.0[${PYTHON_USEDEP}]
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
    standalone? ( dev-python/uvicorn[${PYTHON_USEDEP}] )
	')
	dev-python/misaki[l10n_en,l10n_ja,l10n_ko,l10n_zh,${PYTHON_SINGLE_USEDEP}]
  dev-python/kokoro[${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/pytorch-2.8.0[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
# shellcheck disable=SC2016
BDEPEND="test? (
		$(python_gen_cond_dep '
			dev-python/httpx[${PYTHON_USEDEP}]
			>=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
			dev-python/pytest-asyncio[${PYTHON_USEDEP}]
			dev-python/pytest-cov[${PYTHON_USEDEP}]
			>=dev-python/tomli-2.0.1[${PYTHON_USEDEP}]
		')
  )"

PATCHES=(
	"${FILESDIR}/${PN}-rename-package.patch"
	"${FILESDIR}/${PN}-quiet-logging.patch"
)

src_prepare() {
	distutils-r1_src_prepare
	mv api/src kokoro_fastapi || die
}

src_install() {
	distutils-r1_src_install
	insinto "/var/lib/${PN}/web"
	doins -r web/*
	local item
	for item in models voices; do
		insinto "/var/lib/${PN}/${item}"
		doins -r kokoro_fastapi/${item}/*
	done
  insinto "/var/lib/${PN}/models/v1_0"
  newins "${DISTDIR}/${P}-kokoro-v1_0.pth" "kokoro-v1_0.pth"
  newins "${DISTDIR}/${P}-kokoro-v1_0-config.json" "config.json"
	if use standalone; then
		systemd_dounit "${FILESDIR}/${PN}-cpu.service"
		systemd_dounit "${FILESDIR}/${PN}-gpu.service"
		newinitd "${FILESDIR}/${PN}-cpu.initd" "${PN}-cpu"
		newinitd "${FILESDIR}/${PN}-gpu.initd" "${PN}-gpu"
	fi
	python_moduleinto kokoro_fastapi/core
	python_domodule kokoro_fastapi/core/openai_mappings.json
}

pkg_postinst() {
	if use standalone; then
		chown -R "${PN}:${PN}" "/var/lib/${PN}" || die
	fi
	elog
	elog "For CUDA support, add the kokoro-fastapi user to the video group:"
	elog
	elog "  gpasswd -a kokoro-fastapi video"
	elog
}

EPYTEST_PLUGINS=( pytest-{asyncio,cov} )
distutils_enable_tests pytest
