# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A library for manipulation of IP (and MAC) address representations."
HOMEPAGE="https://github.com/mirage/ocaml-ipaddr"
SRC_URI="https://github.com/mirage/ocaml-ipaddr/archive/refs/tags/v${PV}.tar.gz -> ipaddr-${PV}.tar.gz"
S="${WORKDIR}/ocaml-ipaddr-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
