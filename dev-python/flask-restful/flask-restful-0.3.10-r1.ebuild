# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_PN="Flask-RESTful"
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Simple framework for creating REST APIs for Flask"
HOMEPAGE="https://github.com/flask-restful/flask-restful https://pypi.org/project/Flask-RESTful/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/aniso8601-0.82[${PYTHON_USEDEP}]
	>=dev-python/flask-0.8[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/blinker[${PYTHON_USEDEP}]
		dev-python/nose2[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	# reqparse's default ("json", "values") location 415s on form posts with Werkzeug 2.3+.
	"${FILESDIR}/${PN}-werkzeug-json.patch"
	# Drop nose (unittest assertions, run by nose2, which keeps the generator tests),
	# and catch the tests up with Flask 3, Werkzeug 3 and tzdata 2024b.
	"${FILESDIR}/${PN}-tests.patch"
)

python_test() {
	"${EPYTHON}" -m nose2 -v tests || die "Tests failed with ${EPYTHON}"
}
