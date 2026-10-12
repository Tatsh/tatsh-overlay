# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
# dev-python/magika is limited to these by sci-libs/onnxruntime[python].
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Convert files and office documents to Markdown."
HOMEPAGE="https://github.com/microsoft/markitdown https://pypi.org/project/markitdown/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# Upstream caps mammoth at ~=1.11.0, but the only call markitdown makes is
# mammoth.convert_to_html(stream, style_map=...), which 1.12 still forwards
# through *args/**kwargs unchanged.
RDEPEND="
	<dev-python/magika-0.7[${PYTHON_USEDEP}]
	>=dev-python/magika-0.6.1[${PYTHON_USEDEP}]
	>=dev-python/mammoth-1.11.0[${PYTHON_USEDEP}]
	>=dev-python/pdfminer-six-20251230[${PYTHON_USEDEP}]
	>=dev-python/pdfplumber-0.11.9[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/markdownify[${PYTHON_USEDEP}]
	dev-python/openpyxl[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/python-pptx[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/xlrd[${PYTHON_USEDEP}]
"

pkg_postinst() {
	elog "DOCX, PPTX, XLSX, XLS and PDF conversion are enabled."
	elog
	elog "These converters need packages that are not pulled in here:"
	elog "  Outlook .msg     dev-python/olefile"
	elog "  audio            dev-python/pydub and SpeechRecognition"
	elog "  YouTube          youtube-transcript-api"
	elog "  Azure Document Intelligence and Content Understanding"
	elog "                   azure-ai-documentintelligence,"
	elog "                   azure-ai-contentunderstanding, azure-identity"
}
