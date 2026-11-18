# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-r1

MY_PN="${PN%-bin}"
MY_TAG="manylinux_2_27_x86_64.manylinux_2_28_x86_64"

DESCRIPTION="Language and compiler for custom deep learning operations"
HOMEPAGE="https://triton-lang.org/ https://github.com/triton-lang/triton"
# Building needs a pinned LLVM/MLIR snapshot that upstream downloads at build
# time. The wheels are zips; renaming them lets the default src_unpack work.
SRC_URI="
	python_targets_python3_12? (
		https://files.pythonhosted.org/packages/c1/09/b7012e5bfae67640f268aa584caa80fe1674f6b0da949046b679972c33e3/${MY_PN}-${PV}-cp312-cp312-${MY_TAG}.whl
			-> ${MY_PN}-${PV}-cp312.zip
	)
	python_targets_python3_13? (
		https://files.pythonhosted.org/packages/b0/b6/3394d5548404c1cabd1dadadd28d0b3f9478db1dff8180da53bb3f0a1e19/${MY_PN}-${PV}-cp313-cp313-${MY_TAG}.whl
			-> ${MY_PN}-${PV}-cp313.zip
	)
	python_targets_python3_14? (
		https://files.pythonhosted.org/packages/93/d9/08c75f3459f19ad00425b564058e40efa4bcd79b816064cf27499303ea42/${MY_PN}-${PV}-cp314-cp314-${MY_TAG}.whl
			-> ${MY_PN}-${PV}-cp314.zip
	)
"
S="${WORKDIR}"

# The wheels bundle LLVM/MLIR and NVIDIA's ptxas, cuobjdump, nvdisasm and CUPTI.
LICENSE="MIT Apache-2.0-with-LLVM-exceptions NVIDIA-CUDA"
SLOT="0"
KEYWORDS="-* ~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="bindist mirror strip test"

RDEPEND="${PYTHON_DEPS}"
BDEPEND="app-arch/unzip"

QA_PREBUILT="usr/lib*/python*/site-packages/${MY_PN}/*"

src_unpack() {
	# shellcheck disable=SC2329
	triton_unpack() {
		mkdir "${EPYTHON}" || die
		cd "${EPYTHON}" || die
		unpack "${MY_PN}-${PV}-${EPYTHON/python3./cp3}.zip"
	}
	python_foreach_impl triton_unpack
}

src_install() {
	# shellcheck disable=SC2329
	triton_install() {
		cd "${WORKDIR}/${EPYTHON}" || die
		# Upstream's test libraries, with an empty DT_RUNPATH.
		rm -r "${MY_PN}"/{instrumentation,plugins} || die
		# Backends are found through the entry points in the dist-info.
		python_domodule "${MY_PN}" "${MY_PN}-${PV}.dist-info"
		# python_domodule installs everything 0644; Triton runs these.
		local exe sitedir
		sitedir="$(python_get_sitedir)" || die
		for exe in FileCheck backends/nvidia/bin/{cuobjdump,nvdisasm,ptxas,ptxas-blackwell}; do
			fperms +x "${sitedir#"${EPREFIX}"}/${MY_PN}/${exe}"
		done
	}
	python_foreach_impl triton_install
}
