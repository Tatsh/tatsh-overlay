# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit python-r1

MY_PN="${PN%-bin}"
MY_TAG="cp312-abi3-manylinux_2_27_x86_64.manylinux_2_28_x86_64"

DESCRIPTION="Language and compiler for custom deep learning operations"
HOMEPAGE="https://triton-lang.org/ https://github.com/triton-lang/triton"
# Building needs a pinned LLVM/MLIR snapshot that upstream downloads at build
# time. The wheel is a zip; renaming it lets the default src_unpack work.
# The wheel uses the stable ABI and serves every CPython from 3.12.
SRC_URI="https://files.pythonhosted.org/packages/3f/c9/af85b25e0d98bd921a7646ad1db1c8746250ee04b8f1595982d29b6283cf/${MY_PN}-${PV}-${MY_TAG}.whl
	-> ${MY_PN}-${PV}-abi3.zip"
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

src_prepare() {
	default
	# Upstream's test libraries, with an empty DT_RUNPATH.
	rm -r "${MY_PN}"/{instrumentation,plugins} || die
}

src_install() {
	# shellcheck disable=SC2329
	triton_install() {
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
