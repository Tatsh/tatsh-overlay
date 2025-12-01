# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Map filenames to common MIME types."
HOMEPAGE="https://github.com/mirage/ocaml-magic-mime"
SRC_URI="https://github.com/mirage/ocaml-magic-mime/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
