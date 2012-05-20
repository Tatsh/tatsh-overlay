# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

PHP_EXT_NAME="test_helpers"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3"

inherit php-ext-source-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="An extension for the PHP Interpreter to ease testing of PHP code."
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="${DEPEND}"
SRC_URI="http://pear.phpunit.de/get/test_helpers-1.1.0.tgz"
