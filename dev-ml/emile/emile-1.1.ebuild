# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Parser of email address according RFC822."
HOMEPAGE="https://github.com/dinosaure/emile"
SRC_URI="https://github.com/dinosaure/emile/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/angstrom-0.14.0:=
	>=dev-ml/base64-3.0.0:=
	>=dev-ml/ipaddr-2.7.0:=
	dev-ml/pecu:=
	dev-ml/uutf:="
RDEPEND="${DEPEND}"
