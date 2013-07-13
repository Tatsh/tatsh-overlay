# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

PHP_EXT_NAME="twig"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3 php5-4 php5-5"

inherit php-ext-source-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="C implementation of \\Twig_Template::getAttribute()"
LICENSE="MIT GPL-2 BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
SRC_URI="http://files.tatsh.net/$PN-$PV.tar.bz2"
