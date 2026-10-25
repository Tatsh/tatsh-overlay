# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_PN="changedetection.io"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi systemd

DESCRIPTION="Website change detection and monitoring service"
HOMEPAGE="https://changedetection.io https://github.com/dgtlmoon/changedetection.io"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# Optional and not packaged: gevent (SOCKETIO_MODE=gevent), pyppeteer-ng and pyppeteerstealth (the
# Puppeteer fetcher), litellm and rank-bm25 (LLM features). orjson (deprecated in ::gentoo) only
# speeds up JSON; the stdlib is used without it.
RDEPEND="acct-group/changedetection
	acct-user/changedetection
	app-arch/brotli[python,${PYTHON_USEDEP}]
	>=dev-python/apprise-2.0.1[${PYTHON_USEDEP}]
	dev-python/arrow[${PYTHON_USEDEP}]
	>=dev-python/babel-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.15.0[${PYTHON_USEDEP}]
	dev-python/blinker[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	>=dev-python/cryptography-50.0.2[${PYTHON_USEDEP}]
	dev-python/diff-match-patch[${PYTHON_USEDEP}]
	>=dev-python/elementpath-5.1.4[${PYTHON_USEDEP}]
	dev-python/extruct[${PYTHON_USEDEP}]
	>=dev-python/feedgen-1.0[${PYTHON_USEDEP}]
	>=dev-python/feedparser-6.0[${PYTHON_USEDEP}]
	>=dev-python/flask-3.1[${PYTHON_USEDEP}]
	<dev-python/flask-4[${PYTHON_USEDEP}]
	>=dev-python/flask-babel-4.0.0[${PYTHON_USEDEP}]
	dev-python/flask-compress[${PYTHON_USEDEP}]
	dev-python/flask-cors[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.6.3[${PYTHON_USEDEP}]
	dev-python/flask-paginate[${PYTHON_USEDEP}]
	dev-python/flask-restful[${PYTHON_USEDEP}]
	>=dev-python/flask-socketio-5.6.1[${PYTHON_USEDEP}]
	<dev-python/flask-socketio-6[${PYTHON_USEDEP}]
	>=dev-python/flask-wtf-1.3[${PYTHON_USEDEP}]
	>=dev-python/greenlet-3.5.6[${PYTHON_USEDEP}]
	>=dev-python/inscriptis-2.7[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1[${PYTHON_USEDEP}]
	dev-python/jq[${PYTHON_USEDEP}]
	>=dev-python/jsonpath-ng-1.9.1[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.26.0[${PYTHON_USEDEP}]
	dev-python/linkify-it-py[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	>=dev-python/lxml-6.1.3[${PYTHON_USEDEP}]
	>=dev-python/openapi-core-0.23[${PYTHON_USEDEP}]
	dev-python/openpyxl[${PYTHON_USEDEP}]
	dev-python/paho-mqtt[${PYTHON_USEDEP}]
	dev-python/panzi-json-logic[${PYTHON_USEDEP}]
	>=dev-python/pluggy-1.6[${PYTHON_USEDEP}]
	dev-python/price-parser[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/puremagic[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.13.5[${PYTHON_USEDEP}]
	dev-python/pysocks[${PYTHON_USEDEP}]
	>=dev-python/python-engineio-4.14.0[${PYTHON_USEDEP}]
	>=dev-python/python-socketio-5.17.0[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/rapidfuzz[${PYTHON_USEDEP}]
	>=dev-python/referencing-0.37.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-file[${PYTHON_USEDEP}]
	>=dev-python/segno-1.6.6[${PYTHON_USEDEP}]
	>=dev-python/selenium-4.50.0[${PYTHON_USEDEP}]
	>=dev-python/timeago-1.0[${PYTHON_USEDEP}]
	dev-python/tzdata[${PYTHON_USEDEP}]
	>=dev-python/validators-0.35[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-3.1.9[${PYTHON_USEDEP}]
	>=dev-python/wtforms-3.2[${PYTHON_USEDEP}]"

src_prepare() {
	# Upstream pins exact versions and lists optional and test-only packages here; Portage handles
	# the dependencies instead.
	: > requirements.txt || die
	distutils-r1_src_prepare
}

python_install_all() {
	distutils-r1_python_install_all
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"
}

# Tests need a running server and network access.
