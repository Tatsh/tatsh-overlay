# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DICT_PV="3.1.0"

DESCRIPTION="UniDic packaged for Python"
HOMEPAGE="https://pypi.org/project/unidic/ https://github.com/polm/unidic-py"
# The dictionary "python -m unidic download" fetches into site-packages.
SRC_URI+="
	https://cotonoha-dic.s3-ap-northeast-1.amazonaws.com/unidic-${DICT_PV}.zip
		-> unidic-dict-${DICT_PV}.zip
"

LICENSE="MIT || ( BSD GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64"

# plac is only for "python -m unidic download", which the bundled dictionary makes
# unnecessary.
RDEPEND="
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.41.1[${PYTHON_USEDEP}]
	>=dev-python/wasabi-0.6.0[${PYTHON_USEDEP}]
"
BDEPEND="app-arch/unzip"

python_install() {
	distutils-r1_python_install
	dosym -r /usr/share/unidic/dicdir "$(python_get_sitedir)/unidic/dicdir"
}

python_install_all() {
	distutils-r1_python_install_all
	# Lay the dictionary out the way unidic/download.py does.
	insinto /usr/share/unidic
	doins -r "${WORKDIR}/unidic"
	mv "${ED}/usr/share/unidic/unidic" "${ED}/usr/share/unidic/dicdir" || die
	echo "unidic-${DICT_PV}+2021-08-31" > "${ED}/usr/share/unidic/dicdir/version" || die
	echo '# This is a dummy file.' > "${ED}/usr/share/unidic/dicdir/mecabrc" || die
}
