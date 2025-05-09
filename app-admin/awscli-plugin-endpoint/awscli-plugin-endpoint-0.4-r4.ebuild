# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit distutils-r1 pypi

DESCRIPTION="Provides service endpoint configuration per service on profile."
HOMEPAGE="https://pypi.org/project/awscli-plugin-endpoint/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="|| ( app-admin/awscli app-admin/awscli-bin )"

S="${WORKDIR}/${P}"

pkg_postinst() {
	einfo
	einfo "To enable this plugin, you must run:"
	einfo
	einfo "    aws configure set plugins.endpoint awscli_plugin_endpoint"
	einfo
	einfo "If you are using awscli-bin (awscli 2), you must add this line to"
	einfo "your configuration file under the [plugins] section:"
	einfo
	einfo "    cli_legacy_plugin_path = /usr/lib/python3.10/site-packages"
	einfo
	einfo "Be aware that you will have to update this line when you update to"
	einfo "a new Python version."
	einfo
}
