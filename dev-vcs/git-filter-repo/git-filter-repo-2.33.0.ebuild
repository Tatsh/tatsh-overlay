# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{6..9} )
inherit python-r1

DESCRIPTION="Quickly rewrite git repository history (filter-branch replacement)"
HOMEPAGE="https://github.com/newren/git-filter-repo"
SRC_URI="https://github.com/newren/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="examples"

RDEPEND="${PYTHON_DEPS}
	dev-vcs/git"

DOCS=(
	README.md
	Documentation/converting-from-bfg-repo-cleaner.md
	Documentation/converting-from-filter-branch.md
)

src_prepare() {
	rm "${PN//-/_}.py"
	cp "${PN}" "${PN//-/_}.py"
	if use examples; then
		cp contrib/filter-repo-demos/README.md README-examples.md
		DOCS+=( README-examples.md )
		rm contrib/filter-repo-demos/README.md
	fi
	default
}

src_compile() {
	:
}

src_install() {
	dobin "${PN}"
	python_replicate_script "${D}"/usr/bin/${PN}
	python_foreach_impl python_domodule "${PN//-/_}.py"
	doman "Documentation/man1/${PN}.1"
	if use examples; then
		dobin contrib/filter-repo-demos/*
		for name in contrib/filter-repo-demos/*; do
			python_replicate_script "${D}"/usr/bin/$(basename "$name")
		done
	fi
	einstalldocs
}
