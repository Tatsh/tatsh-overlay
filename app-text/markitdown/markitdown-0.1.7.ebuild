# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Convert files and office documents to Markdown."
HOMEPAGE="https://github.com/microsoft/markitdown
	https://pypi.org/project/markitdown/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/magika-0.7[${PYTHON_USEDEP}]
	>=dev-python/magika-0.6.1[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/markdownify[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

pkg_postinst() {
	elog "Only the base converters are enabled. Upstream gates PDF, DOCX,"
	elog "PPTX, XLSX, audio transcription and YouTube support behind extras"
	elog "whose dependencies are not pulled in here."
}
