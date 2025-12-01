# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Helpers for using React with Lwt."
HOMEPAGE="https://github.com/ocsigen/lwt"
SRC_URI="https://github.com/ocsigen/lwt/archive/refs/tags/5.7.0.tar.gz -> lwt-5.7.0.tar.gz"
S="${WORKDIR}/lwt-5.7.0"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-ml/lwt-3.0.0:=
	>=dev-ml/react-1.0.0:="
RDEPEND="${DEPEND}"
BDEPEND=">=dev-ml/cppo-1.1.0"
