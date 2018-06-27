# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="A Git extension to make it easy to use GitFlow with GitHub."
HOMEPAGE="https://github.com/datasift/gitflow"
SRC_URI="https://github.com/datasift/gitflow/archive/1.5.3.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-vcs/git-flow-0.4.1
	>=dev-util/shflags-1.0.3
"

S="${WORKDIR}/${P/hub/git}"

src_install() {
	local -r hubflow_dir="/usr/share/${P}"

	eval "export $(egrep ^EXEC_FILES= install.sh | head -n 1)"
	eval "export $(egrep ^SCRIPT_FILES= install.sh | head -n 1)"
	sed -e "s:^export HUBFLOW_DIR=.*:export HUBFLOW_DIR=${hubflow_dir}:" -i git-hf

	exeinto /usr/bin
	for i in $EXEC_FILES; do
		doexe "$i"
	done
	for i in $SCRIPT_FILES; do
		[[ "$i" = 'hubflow-common' ]] && continue
		[[ "$i" = 'hubflow-shFlags' ]] && continue
		[[ "$i" = 'git-hf-update' ]] && continue
		doexe "$i"
	done

	insinto "$hubflow_dir"
	doins hubflow-common

	dosym "${EPREFIX}/usr/share/misc/shflags" "${hubflow_dir}/hubflow-shFlags"

	dodoc AUTHORS Changes.mdown LICENSE README.md
}
