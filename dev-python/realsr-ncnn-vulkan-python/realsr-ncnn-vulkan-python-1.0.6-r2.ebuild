# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2,3,4,5} )
inherit cmake pypi python-r1

DESCRIPTION="A Python FFI of nihui/realsr-ncnn-vulkan achieved with SWIG"
HOMEPAGE="https://pypi.org/project/realsr-ncnn-vulkan-python/"
# The test input lives in the realsr-ncnn-vulkan submodule's images/, which the sdist leaves out.
REALSR_COMMIT="b7f890ee2704ccea76c73d9fd4d5b3298dd1beca"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")
	test? (
		https://raw.githubusercontent.com/nihui/realsr-ncnn-vulkan/${REALSR_COMMIT}/images/0.png
			-> ${P}-test-0.png
	)"
MY_PN_U="${PN//-/_}"
S="${WORKDIR}/${P}/${MY_PN_U}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
DEPEND="dev-libs/ncnn:=[vulkan]"
BDEPEND="dev-lang/swig dev-util/glslang
	test? (
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

PATCHES=(
	"${FILESDIR}/${PN}-0001-fix-for-newer-glslang.patch"
)

src_prepare() {
	python_foreach_impl cmake_src_prepare
}

custom_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=$(python_get_sitedir)/${MY_PN_U}"
		"-DPY_VERSION=${EPYTHON:6}"
		-DBUILD_SHARED_LIBS=OFF
		-DCALL_FROM_SETUP_PY=ON
		-DUSE_SYSTEM_NCNN=ON
		-Wno-dev
	)
	cmake_src_configure
}

src_configure() {
	python_foreach_impl custom_configure
}

src_compile() {
	python_foreach_impl cmake_src_compile
}

custom_test() {
	# Stage the module the way custom_install lays it out, then run the tests on it.
	local root="${T}/test-${EPYTHON}"
	mkdir -p realsr-ncnn-vulkan/images || die
	cp "${DISTDIR}/${P}-test-0.png" realsr-ncnn-vulkan/images/0.png || die
	DESTDIR="${root}" cmake --install "${BUILD_DIR}" || die
	grep -E '\s+write_top_level_init="' ../setup.py | sed \
		-re 's/.*"([^"]+)",$/\1/' > "${root}$(python_get_sitedir)/${MY_PN_U}/__init__.py" || die
	PYTHONPATH="${root}$(python_get_sitedir)" epytest ../tests
}

src_test() {
	# Vulkan. The tests fall back to the CPU without a usable GPU, but that path
	# segfaults while loading the model.
	local dev
	for dev in /dev/dri /dev/nvidia*; do
		[[ -e ${dev} ]] && addwrite "${dev}"
	done
	# The NVIDIA driver also (re)creates /dev/char links and writes per-thread state.
	addpredict /dev/char
	addwrite /proc/self/task
	python_foreach_impl custom_test
}

custom_install() {
	cmake_src_install
	rm -f "${D}/$(python_get_sitedir)/${MY_PN_U}/LICENSE" || die
	grep -E '\s+write_top_level_init="' ../setup.py | sed \
		-re 's/.*"([^"]+)",$/\1/' > "${D}/$(python_get_sitedir)/${MY_PN_U}/__init__.py" || die
}

src_install() {
	python_foreach_impl custom_install
}
