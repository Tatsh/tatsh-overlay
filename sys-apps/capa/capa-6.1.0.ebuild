# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="The FLARE team's open-source tool to identify capabilities in executable files."
HOMEPAGE="https://github.com/mandiant/capa"
SRC_URI="https://github.com/mandiant/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/mandiant/${PN}-rules/archive/refs/tags/v${PV}.tar.gz -> ${PN}-rules-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/colorama
	dev-python/dncil
	dev-python/dnfile
	dev-python/halo
	dev-python/ida-settings
	dev-python/networkx
	dev-python/pefile
	dev-python/protobuf-python
	dev-python/pydantic
	dev-python/pyelftools
	dev-python/pyyaml
	dev-python/ruamel-yaml
	dev-python/tabulate
	dev-python/termcolor
	dev-python/tqdm
	dev-python/viv-utils
	dev-util/vivisect
	dev-python/wcwidth"

python_prepare_all() {
	sed -r \
		-e 's|^packages = .*|packages = ["capa", "capa.features", "capa.features.extractors", "capa.features.extractors.binja", "capa.features.extractors.dnfile", "capa.features.extractors.ida", "capa.features.extractors.viv", "capa.features.freeze", "capa.ida.plugin",  "capa.ida", "capa.render", "capa.render.proto", "capa.rules"]|' \
		-i pyproject.toml || die
	sed -re "s|return Path\(__file__\).resolve\(\).parent.parent|return Path('${EPREFIX}/usr/share/${PN}')|" \
		-i capa/main.py || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	insinto /usr/share/${PN}/rules
	doins -r "${WORKDIR}/${PN}-rules-${PV}/"*
	insinto /usr/share/${PN}/sigs
	doins sigs/*.sig
}

distutils_enable_tests pytest
