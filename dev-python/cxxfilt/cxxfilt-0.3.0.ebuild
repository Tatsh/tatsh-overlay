# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12} )

inherit distutils-r1 pypi

DESCRIPTION="Python interface to c++filt / abi::__cxa_demangle"
HOMEPAGE="https://github.com/afq984/python-cxxfilt"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
RESTRICT="test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
