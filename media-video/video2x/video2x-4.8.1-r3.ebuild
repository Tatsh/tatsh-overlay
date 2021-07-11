# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_9 )

inherit desktop python-single-r1

DESCRIPTION="A lossless video/GIF/image upscaler."
HOMEPAGE="https://video2x.org/ https://github.com/k4yt3x/video2x"
AVALON_SHA="4c70d635442a8d11a38fce6fc3de42340027cc7e"
SRC_URI="https://github.com/k4yt3x/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/k4yt3x/avalon-framework/archive/${AVALON_SHA}.tar.gz -> ${PN}-avalon-${AVALON_SHA:0:7}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="$(python_gen_cond_dep '
		dev-python/colorama[${PYTHON_USEDEP}]
		app-arch/patool[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
	')"

PATCHES=( "${FILESDIR}/${PN}-paths.patch" )

src_prepare() {
	sed -r \
		-e "s/^from bilogger/from ${PN}_lib.bilogger/g" \
		-e "s/^from upscaler/from ${PN}_lib.upscaler/g" \
		-e "s/^from wrappers/from ${PN}_lib.wrappers/g" \
		-e "s/^from exceptions/from ${PN}_lib.exceptions/g" \
		-e "s/^from image_cleaner/from ${PN}_lib.image_cleaner/g" \
		-e "s/^from progress_monitor/from ${PN}_lib.progress_monitor/g" \
		-e "s/^from avalon_framework/from ${PN}_lib.avalon_framework/g" \
		-e "s/import_module\(f\"wrappers\./import_module(f\"${PN}_lib.wrappers./g" \
		-i src/*.py src/wrappers/*.py || die
	sed -r \
		-e "s|^LOCALE_DIRECTORY =.*|LOCALE_DIRECTORY = '${EPREFIX}/usr/share/locale'|" \
		-i src/${PN}.py || die
	sed -r \
		-e "s|self.${PN}_icon_path =.*|self.${PN}_icon_path = '${EPREFIX}/usr/share/pixmaps/${PN}.png'|" \
		-e "s|uic\.loadUi\(str\(resource_path\(\"video2x_gui.ui\"\)\),|uic.loadUi('${EPREFIX}/usr/share/${PN}/${PN}_gui.ui',|" \
		-i src/${PN}_gui.py || die
	cp "${WORKDIR}/avalon-framework-${AVALON_SHA}/__init__.py" src/avalon_framework.py || die
	default
	sed -r -e "s|@EPREFIX@|${EPREFIX}|g" -i src/*.py src/wrappers/*.py || die
}

src_install() {
	python_moduleinto ${PN}_lib
	touch src/wrappers/__init__.py src/__init__.py || die
	python_domodule src/wrappers src/{__init__,avalon_framework,bilogger,exceptions,image_cleaner,progress_monitor,upscaler}.py
	python_doscript src/${PN}.py src/${PN}_gui.py
	use nls && domo src/locale/zh_CN/LC_MESSAGES/zh_CN.mo
	doicon src/images/${PN}.png
	insinto /usr/share/${PN}
	make_desktop_entry ${PN}_gui.py Video2X ${PN}
	doins src/*.ui
	newins src/${PN}.yaml ${PN}.default.yaml
	einstalldocs
}
