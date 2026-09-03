# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

PYPI_VERIFY_REPO="https://github.com/Tatsh/smlab"

inherit distutils-r1 pypi

DESCRIPTION="Generate StepMania dance-single charts from audio."
HOMEPAGE="https://pypi.org/project/smlab/ https://github.com/Tatsh/smlab"
# The chart and offset models are 150 MB together and are not part of the sources. smlab searches
# "${EPREFIX}"/usr/share/smlab before it downloads anything (weights.py checks sys.prefix and the
# platformdirs data directories), so installing them is what keeps it off the network.
WEIGHTS_URI="https://github.com/Tatsh/${PN}/releases/download/v${PV}"
SRC_URI+=" ${WEIGHTS_URI}/${P}-chart.pt
	${WEIGHTS_URI}/${P}-offset.pt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# pyproject.toml sets mock_use_standalone_module, so the tests need mock rather than
# unittest.mock. pytest-mock comes in with EPYTEST_PLUGINS.
# shellcheck disable=SC2016
BDEPEND="test? (
	$(python_gen_cond_dep '
		dev-python/mock[${PYTHON_USEDEP}]
	')
)"
# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/bascom-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/click-8.4.2[${PYTHON_USEDEP}]
		>=dev-python/librosa-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/numpy-2.5.2[${PYTHON_USEDEP}]
		>=dev-python/pillow-12.3.0[${PYTHON_USEDEP}]
		>=dev-python/platformdirs-4.11.3[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.18.0[${PYTHON_USEDEP}]
		>=dev-python/soundfile-0.14.0[${PYTHON_USEDEP}]
		>=dev-python/typing-extensions-4.16.0[${PYTHON_USEDEP}]
		>=media-libs/mutagen-1.48.1[${PYTHON_USEDEP}]
	')
	sci-ml/demucs[${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/pytorch-2.11.0[${PYTHON_SINGLE_USEDEP}]"

EPYTEST_PLUGINS=( pytest-mock )

src_install() {
	distutils-r1_src_install

	# hatchling installs only the smlab package, so the man page needs installing by hand.
	doman man/"${PN}".1

	# The digests are checked against the manifest installed at
	# smlab/assets/weights.sha256, so sha256sum -c verifies these in place.
	insinto "/usr/share/${PN}"
	newins "${DISTDIR}/${P}-chart.pt" chart.pt
	newins "${DISTDIR}/${P}-offset.pt" offset.pt
}

pkg_postinst() {
	elog "Run 'smlab weights' to see every directory that is searched, and what was found."
	elog "A locally trained checkpoint overrides the installed one: pass -c, set"
	elog "SMLAB_WEIGHTS_DIR, or put it in ~/.local/share/smlab."
}

distutils_enable_tests pytest
