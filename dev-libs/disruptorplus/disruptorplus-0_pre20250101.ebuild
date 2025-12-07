# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="748e354476e0bf86dfdbb55f1d925222d7ee631b"

DESCRIPTION="C++ implementation of the LMAX Disruptor pattern."
HOMEPAGE="https://github.com/lewissbaker/disruptorplus"
SRC_URI="https://github.com/lewissbaker/disruptorplus/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	doheader -r include/*
	einstalldocs
}
