# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )

inherit python-r1

MY_PN="${PN%-bin}"
MY_TAG="py3-none-manylinux_2_17_x86_64.manylinux2014_x86_64"

DESCRIPTION="Python bindings to PDFium."
HOMEPAGE="https://github.com/pypdfium2-team/pypdfium2 https://pypi.org/project/pypdfium2/"
# Building PDFium from source is not possible inside Portage: upstream's
# build_native.py git-clones PDFium and six Chromium sub-repositories at build
# time and needs a newer GN than any distribution ships. There is no system
# PDFium to link against either. The wheel is a zip; renaming it lets the
# default src_unpack handle it.
SRC_URI="https://files.pythonhosted.org/packages/d3/7c/74a2fb48e5b0d2402d9ca64b39074c722d67e9a8a2c58449a843a8c2329a/${MY_PN}-${PV}-${MY_TAG}.whl
	-> ${P}.zip"
S="${WORKDIR}"

# The bundled libpdfium.so statically links every dependency below.
LICENSE="AGG Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 CC-BY-4.0 FTL
	IJG MIT ZLIB icu libpng2 libtiff"
SLOT="0"
KEYWORDS="-* ~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
BDEPEND="app-arch/unzip"

QA_PREBUILT="usr/lib*/python*/site-packages/${MY_PN}_raw/libpdfium.so"

src_install() {
	python_foreach_impl python_domodule \
		"${MY_PN}" "${MY_PN}_cfg" "${MY_PN}_cli" "${MY_PN}_raw"

	# The wheel declares this console script in its entry_points.txt.
	python_foreach_impl python_newscript - "${MY_PN}" <<-EOF
		#!/usr/bin/env python
		import sys
		from ${MY_PN}_cli.__main__ import cli_main

		sys.exit(cli_main())
	EOF
}
