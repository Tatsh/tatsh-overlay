# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_9 )
inherit desktop python-single-r1

DESCRIPTION="Multi-purpose utility to manage and install Switch files (NSP, NSZ, XCI, XCZ)."
HOMEPAGE="https://github.com/blawar/nut"
SHA="91767609ed4cc65a09c5029b81326aee919e0dc7"
SRC_URI="https://github.com/blawar/nut/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/PyQt5[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/asn1[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/beautifulsoup4[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/certifi[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/colorama[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/filelock[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/flask[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/google-api-python-client[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/google-auth-oauthlib[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/humanize[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pillow[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/qt-range-slider[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pycryptodome[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pycryptoplus[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pycurl[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pyopenssl[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pyusb[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/tqdm[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/unidecode[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/urllib3[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/watchdog[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/zstandard[${PYTHON_USEDEP}]')
"
BDEPEND="media-gfx/imagemagick"

S="${WORKDIR}/${PN}-${SHA}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-move-most-code-to-be-under-n.patch"
	"${FILESDIR}/${PN}-0002-fix-paths-and-make-everythin.patch"
)

src_install() {
	python_domodule nut
	python_newscript ${PN}.py ${PN}
	python_newscript ${PN}_gui.py ${PN}-gui
	convert images/logo.jpg "blawar-${PN}.png" || die
	doicon "blawar-${PN}.png"
	make_desktop_entry ${PN}-gui ${PN^^} "blawar-${PN}"
	insinto /usr/share/blawar-${PN}
	doins Certificate.cert ShopN.pem Ticket.tik conf/nut.default.conf keys_template.txt
	einstalldocs
}
