# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 python-single-r1 systemd

COMMIT="996bc8dbe141d5c233978ef7cc50cb6351498bb9"

DESCRIPTION="An OAI compatible exllamav2 API that's both lightweight and fast."
HOMEPAGE="https://github.com/theroyallab/tabbyAPI"
SRC_URI="https://github.com/theroyallab/tabbyAPI/archive/${COMMIT}.tar.gz -> ${P}-${COMMIT:0:7}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="standalone"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

	# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	standalone? (
		acct-group/tabbyapi
		acct-group/video
		acct-user/tabbyapi
	)
	$(python_gen_cond_dep '
		>=dev-python/aiofiles-0[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/async-lru[${PYTHON_USEDEP}]
		>=dev-python/fastapi-0.115[${PYTHON_USEDEP}]
		>=dev-python/formatron-0.4.11[${PYTHON_USEDEP}]
		>=dev-python/httptools-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/jinja2-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/kbnf-0.4.1[${PYTHON_USEDEP}]
		dev-python/loguru[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pydantic-settings[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
		>=dev-python/sse-starlette-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/uvicorn-0.28.1[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
	')
	sci-ml/pytorch[${PYTHON_SINGLE_USEDEP}]
	sci-ml/exllamav2[${PYTHON_SINGLE_USEDEP}]
	sci-ml/exllamav3[${PYTHON_SINGLE_USEDEP}]
	sci-ml/huggingface_hub[${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/tokenizers-0.21.0[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/tabbyAPI-${COMMIT}"

PATCHES=(
	"${FILESDIR}/${PN}-reorganize.patch"
	"${FILESDIR}/${PN}-config-path.patch"
	"${FILESDIR}/${PN}-auth-path.patch"
)

DOCS=( README.md config_sample.yml )

src_prepare() {
	mkdir tabbyapi || die
	mv backends common endpoints main.py tabbyapi/ || die
	find tabbyapi -type d -exec touch {}/__init__.py \; || die
	find tabbyapi -name '*.py' -type f -exec sed -i \
		-e 's|^from common |from tabbyapi.common |g' \
		-e 's|^from common\.|from tabbyapi.common.|g' \
		-e 's|^from endpoints\.|from tabbyapi.endpoints.|g' \
		-e 's|^from backends\.|from tabbyapi.backends.|g' \
		-e 's|^import common\b|import tabbyapi.common|g' \
		-e 's|^import endpoints\b|import tabbyapi.endpoints|g' \
		-e 's|^import backends\b|import tabbyapi.backends|g' \
		-e 's|^    from backends\b|    from tabbyapi.backends|g' \
		{} + || die
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	keepdir /var/lib/tabbyapi/loras
	keepdir /var/lib/tabbyapi/models
	insinto /var/lib/tabbyapi
	rm templates/place_your_templates_here.txt || die
	doins -r sampler_overrides templates
	if use standalone; then
		systemd_dounit "${FILESDIR}/${PN}."{socket,service} "${FILESDIR}/${PN}-proxy.service"
		newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	fi
}

pkg_postinst() {
	if use standalone; then
		chown -R tabbyapi:tabbyapi /var/lib/tabbyapi || die
		elog
		elog "If you want the API to run forever, enable the tabbyapi.service. If you want the"
		elog "service to be on-demand and shut down when not in use (after 5 minutes of inactivity),"
		elog "enable tabbyapi.socket instead."
		elog
		elog "In the latter case, configure TabbyAPI to run on 127.0.0.1:4800. Ensure port 5000 is open"
		elog "in your firewall settings. It is normal for the first request to fail while the service"
		elog "is starting up."
		elog
		elog "If you do not like the default ports, you can use systemd drop-in files to override them."
		elog "See https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html#id-1.14.3"
		elog "for details."
		elog
	fi
	elog
	elog "Please copy config_sample.yml to /etc/tabbyapi/config.yml and modify it as needed."
	elog
}
