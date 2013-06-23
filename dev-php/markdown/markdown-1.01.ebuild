# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

PHP_EXT_NAME="markdown"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3 php5-4 php5-5"

inherit php-ext-source-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Markdown parser for PHP using a PEG-based parser."
LICENSE="MIT GPL-2 BSD"
SLOT="0"
IUSE=""

DEPEND="dev-libs/peg-markdown"
RDEPEND="${DEPEND}"
SRC_URI="http://files.tatsh.net/$PN-$PV.tar.bz2"
