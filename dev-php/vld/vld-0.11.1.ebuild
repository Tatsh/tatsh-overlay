# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

PHP_EXT_NAME="vld"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3 php5-4"

inherit php-ext-source-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="The Vulcan Logic Disassembler hooks into the Zend Engine and
dumps all the opcodes (execution units) of a script."
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="${DEPEND}"
SRC_URI="http://pecl.php.net/get/vld-0.11.1.tgz"
