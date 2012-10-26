# Thanks to olemarkus
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

PHP_EXT_NAME="runkit"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3"

inherit php-ext-source-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Crazy stuff"
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples"

RDEPEND="${DEPEND}"
SRC_URI="https://github.com/downloads/zenovich/runkit/runkit-1.0.3.tar"
