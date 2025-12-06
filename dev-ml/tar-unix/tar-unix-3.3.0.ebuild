# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Decode and encode tar format files from Unix."
HOMEPAGE="https://github.com/mirage/ocaml-tar"
SRC_URI="https://github.com/mirage/ocaml-tar/archive/refs/tags/v${PV}.tar.gz -> tar-${PV}.tar.gz"
S="${WORKDIR}/ocaml-tar-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/lwt-5.7.0:=
	dev-ml/tar:="
RDEPEND="${DEPEND}"
