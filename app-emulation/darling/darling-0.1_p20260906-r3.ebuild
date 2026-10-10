# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {17..23} )

inherit cmake fcaps flag-o-matic llvm-r2

DARLING_SHA="60ba801decee7a00782f74f6be4c8ffb013f79ff"
# Submodules used by the stock component set: "<path> <darlinghq repository> <commit>".
# cctools-port and bootstrap_cmds come from sys-devel/darling-cctools and dev-util/darling-mig.
DARLING_SUBMODULES=(
	"src/external/AvailabilityVersions darling-AvailabilityVersions e28c029a8fa46fa933cbf6d6d9a1c00978c5fad1"
	"src/external/BerkeleyDB darling-BerkeleyDB 1411173f0eb71f96ab6134de4e052d16acb8c673"
	"src/external/DSTools darling-DSTools e015256b16965ac032412f2277c608c7213c03b3"
	"src/external/DirectoryService darling-DirectoryService feb9742f574ab812a210634fd3997f19b645095f"
	"src/external/Heimdal darling-Heimdal 3dfb09751063d6c144143edfb2ef13aa3e8c57de"
	"src/external/IOKitTools darling-IOKitTools df58be2f134f7adbdd3c760a165ad3501ee82fb5"
	"src/external/IOKitUser darling-iokituser 534684e6748dffbd875c6cd1942477a52b66a077"
	"src/external/IOKitUser/darling/submodules/IOGraphics darling-IOGraphics 905186151d713259296f3ae9458195a7097ea323"
	"src/external/IOKitUser/darling/submodules/IOHIDFamily darling-IOHIDFamily 189e98e32092d5f5a2c365cc85fd36ac7da2d371"
	"src/external/IONetworkingFamily darling-IONetworkingFamily 28afb431947b8e8dbbb120db7632ba6de229bf23"
	"src/external/IOStorageFamily darling-iostoragefamily 33178aef923d9c99f1819db2ada253054f4dd812"
	"src/external/Libinfo darling-Libinfo 93d242ce3f86d1de67522279edb3a2dcb23f30c7"
	"src/external/MITKerberosShim darling-MITKerberosShim 39c014d0c54f9ae922be0d697aa6cc1b19c117b6"
	"src/external/OpenDirectory darling-opendirectory 67a8ad2ed0b06775bf53839446e2df7d49ab1c96"
	"src/external/OpenLDAP darling-openldap 3b15390bbcad8234aabb3246b0552105b17118d0"
	"src/external/SecurityTokend darling-SecurityTokend c826860db4061667af6f0c3aa55282aab0924e1a"
	"src/external/SmartCardServices darling-SmartCardServices ec53ce56972565047a716ab166176f203f520393"
	"src/external/WTF darling-WTF 88a36e496a6f285a9e15140c2c431b817bae353b"
	"src/external/adv_cmds darling-adv_cmds 56dcf5ebeb822650d7929f666be58544b2391f6e"
	"src/external/apr darling-apr 5aa6eba89e497a67f1b9db7842371141a8616674"
	"src/external/architecture darling-architecture 63162c4744e9bd07673d4c29f8825f105f670e44"
	"src/external/awk darling-awk 5d46e527461bce5fa10b89320a1c6ce5f1ae38b6"
	"src/external/bash darling-bash 2ebbba45039182784202b17069e122367ee63946"
	"src/external/basic_cmds darling-basic_cmds b1ed4f0f6a981590542071d8b36535cf3e441be0"
	"src/external/bc darling-bc 666e93c8223f509ae9c3c69e3c20af45d49a749c"
	"src/external/bind9 darling-bind9 7542d50b3087edb4a46a2bdb11ba75034aa2bffa"
	"src/external/bsm darling-bsm bec0dd61bb07469d1fcb3985822d350abc9934f7"
	"src/external/bzip2 darling-bzip2 dc8c6839093afed1f288715260d32314ad362084"
	"src/external/cctools darling-cctools 8777b6dc7c4de87087c028e17db075795b3684d3"
	"src/external/cfnetwork darling-cfnetwork e7e3db881008d883f82914765a72ce842bcba735"
	"src/external/cocotron darling-cocotron c8d38d16a9f613d300157bebbab2b9501bc0c274"
	"src/external/commoncrypto darling-commoncrypto 2434540f41a5f94f149cfddd67da244961b716e5"
	"src/external/compiler-rt darling-compiler-rt 5fd9bc0effa307b99b35da59ce579e8e031c22da"
	"src/external/configd darling-configd 98e52de19c52f7938e581ed20385f38abd7fa197"
	"src/external/copyfile darling-copyfile ed6094c9a2f8ba19aa55b7b504c3665797078e8f"
	"src/external/corecrypto darling-corecrypto 875f1cd9e75b0029d872b88ce8a77da276c00c84"
	"src/external/corefoundation darling-corefoundation a3640a77410cf1825f7855172b1551ae7917c461"
	"src/external/corefoundation/submodules/swift-corelibs-foundation darling-swift-corelibs-foundation ea1ea0bb416025a8cc5a282df03c2e8f12788e2d"
	"src/external/coretls darling-coretls b61a4f075726e7d5ef4652033f8d7b829c008d06"
	"src/external/crontabs darling-crontabs b5bc00d2a75f6c622976e2ebbe244fb2d7d602ea"
	"src/external/csu darling-Csu 93b25cf0930a727b44fa50893bffd71056ad032f"
	"src/external/cups darling-cups 51b7c251ef5ff81adc20284544394de8cc2e1315"
	"src/external/curl darling-curl 92f54fd7eceabed2c2382a4acc0f7293dedd92ff"
	"src/external/darling-dmg darling-dmg 1a6de10c5886c40a414090701b2520bd0417ce29"
	"src/external/darlingserver darlingserver 89751e64bc6c2082f7725061824ee0e33395b0de"
	"src/external/dbuskit darling-dbuskit 890e51fda949e4dd2c46765e39074f790c10ca18"
	"src/external/doc_cmds darling-doc_cmds 60c6a2b858abe1f27b441f479aad2b0a9d0f9ba2"
	"src/external/dtrace darling-dtrace fd2a404c772e8ce1d29f210032e9831fa845f688"
	"src/external/dyld darling-dyld 63f667cf06d7ed59553adebb0c8d70a117135ac9"
	"src/external/energytrace darling-energytrace e277fcfd430ddab2d8b52187cf480f2857629104"
	"src/external/expat darling-expat 70006a0c32d7c8653c11e53fc0c905f1bb498218"
	"src/external/file darling-file c6ee65265d253d24b1a496f8ca54b5e449fe108c"
	"src/external/file_cmds darling-file_cmds c0d72b5c98888a9d8e0b73cf8aac0df908e615f2"
	"src/external/files darling-files 1c45a50ae0d6ca5bbb8b01d2b588f52bc0e39263"
	"src/external/fmdb fmdb ad2fdd660d02c24b262d64d7d23d3d4645768f44"
	"src/external/foundation darling-foundation 55a4341b470c2a56fea667c1d2167fb074226f04"
	"src/external/gnudiff darling-gnudiff ae0ab716658296164a032be7406f082cdc31c954"
	"src/external/gpatch darling-gpatch 49acc897e8cb832a26b7ac4d2f7db51d3c6ba037"
	"src/external/grep darling-grep 62d70fada3a01de87aff927a86b8df0f7f2a837a"
	"src/external/groff darling-groff 10dd5a6be4915a99065bc15dfc6b6b1e9e1a2714"
	"src/external/icu darling-icu 6b609b2b0ce9a620543f357de4e549f09afec4ea"
	"src/external/installer darling-installer 88764e6149f92f1747442c27ab00231f40de278c"
	"src/external/iokitd darling-iokitd 5549ac4cd2db923c256f016a1381b3bfb716730a"
	"src/external/keymgr darling-keymgr 43b4230aec2e9018b0ffd3069b8b23a34ba257fb"
	"src/external/less darling-less a6bc77c8e72aaa35da92b903172a70eaa4ef78fa"
	"src/external/libarchive darling-libarchive 998d739c602a1b35e2377ec9161e9c13d1d8604d"
	"src/external/libauto darling-libauto 2be7312b25736a8e9fc12058d63cbb79eb5f4e25"
	"src/external/libc darling-Libc 5a38c8dabf9e76b39407c24bc13134e33e5594e6"
	"src/external/libclosure darling-libclosure b4122f19c89512d9e930259a85c5f2674eff2b2b"
	"src/external/libcxx darling-libcxx c47677d3ba33bdabbfb07e75f531831579355a2d"
	"src/external/libcxxabi darling-libcxxabi c9c851718eb304a9aefa097aeaaf8c3bd1dff1bc"
	"src/external/libdispatch darling-libdispatch 380f03c180b80d940134fb35783ddc714784a53a"
	"src/external/libedit darling-libedit f9b44b8541614e33b09451fc2847f7e30bfb9b70"
	"src/external/libffi darling-libffi c796ec121cfd950aa5cc901ea47854a8431948ac"
	"src/external/libiconv darling-libiconv 0d6f47d33a7cc97e468e864099fff74875b41937"
	"src/external/libkqueue darling-libkqueue b0795a2e1dab5331116770139bfea8d832478f5f"
	"src/external/liblzma darling-liblzma 855ebc93f8208ae4b6e77a018d4ba4a4be4d2ab7"
	"src/external/libmalloc darling-libmalloc a57991e2651226a675654bd96e5d9ab6bec288c5"
	"src/external/libnetwork darling-libnetwork 56c5fad43f24a40d8ca7f8a1d0badedfeaf7e64e"
	"src/external/libnotify darling-Libnotify 98156d3f847a3ced6c5f52c12a889047bc4f9b20"
	"src/external/libplatform darling-libplatform 5a3e5b529d25c70257dcfa97e94f1826e71e9f40"
	"src/external/libpthread darling-libpthread f07f265bfbcf071c1adfc808de971e053ea5edc5"
	"src/external/libresolv darling-libresolv cf955392e5449efb269b8b3510c755085fd36a2d"
	"src/external/libressl-2.2.9 darling-libressl c5e9edb9d82ccf5fde5d8ae32b162fec8fe11318"
	"src/external/libressl-2.5.5 darling-libressl 1f663b5bdc9082178717c080e4728fe3e7084de4"
	"src/external/libressl-2.6.5 darling-libressl 30826df38d7c0f416158a94e0112c928188e0327"
	"src/external/libressl-2.8.3 darling-libressl 2a56b36b77a00573c53ccd8e6932eb136172c950"
	"src/external/librpcsvc darling-librpcsvc 0cc1d42e53c61446616719597e96b29aeda51eb3"
	"src/external/libstdcxx darling-libstdcxx 73eb757fe23170c372bef17d6de41787c1271c80"
	"src/external/libsystem darling-Libsystem 08df454b6eb0df9400aa4c39839a7efd6efd2c3c"
	"src/external/libtelnet darling-libtelnet 1ebd4eef48d06e6411ed2a0f60ba5d3fce5ab455"
	"src/external/libtrace darling-libtrace 8cf07f02b15f7dca6436882a03678fff0392eaf6"
	"src/external/libunwind darling-libunwind a91da1a0e262e04eb601152a84228ff733e48422"
	"src/external/libutil darling-libutil e3782a467c248c8d181aba1200ee0642abb65baf"
	"src/external/libxml2 darling-libxml2 d4f2967c8ca84a23a886978098c0520fe2963b92"
	"src/external/libxpc darling-libxpc 394e033333d3c253a12f08a99090c113b0917d00"
	"src/external/libxslt darling-libxslt 50d22bd5b761a1885009b690e48d858ff73e768b"
	"src/external/lzfse lzfse 451f291743bb919cb1b78ced4110402fca52cf97"
	"src/external/mDNSResponder darling-mDNSResponder 7e38ef562b4f3d41bffabb3e30d844d8042d3bbd"
	"src/external/mail_cmds darling-mail_cmds 4afbcf4b9b8a6c33acaf7e9025e51ce72b3725a7"
	"src/external/man darling-man 9af6690f3c7c3c713bb0a20ba1163d3c4278257d"
	"src/external/metal darling-metal ae20248dc144beab899e38752f5a530f28a0ea56"
	"src/external/metal/deps/indium indium 8423a7d2f053167030d2bc4a227f96243c740667"
	"src/external/misc_cmds darling-misc_cmds 85b24ec0e2625d75e7ee75b597b9134a49d18b1f"
	"src/external/nano darling-nano 7514f5f1115fffedd8fc2095107ca86ff82c54d6"
	"src/external/ncurses darling-ncurses 4cc72a9a1bce214593c10811b0154a8d51db0239"
	"src/external/netcat darling-netcat fd29177d56d84f88406e33784c327ebabfe7be58"
	"src/external/network_cmds darling-network_cmds 9a0a90e2021ecdde91986b91f65a236eda158023"
	"src/external/nghttp2 darling-nghttp2 1a1853837b4350d4393bd25e1e4cb6018ab2d918"
	"src/external/objc4 darling-objc4 1a12df76d12bfc9fdfffadb290f7742763568765"
	"src/external/openjdk openjdk 5a541c1844a9508e48b3addaf2d38775683abb38"
	"src/external/openpam darling-openpam 8362545bac04032fcf59287cd66e6f4662a3692b"
	"src/external/openpam/darling/submodules/pam_modules darling-pam_modules 241bbee0da845d1dfebc747b16a62aaed22f165b"
	"src/external/openssh darling-openssh 9137305e5793d31124bcf2fdf0c6fa28c2e3e812"
	"src/external/openssl darling-openssl dc7bf84efa5a0befa0d970d4d5177853ac448d6f"
	"src/external/openssl_certificates darling-openssl_certificates cca4f47e3ca18b58961157ef0ec6a6fc135b8cd2"
	"src/external/passwordserver_sasl darling-passwordserver_sasl 45019fa25adf5ad5713d9e39df3b72e420dccc96"
	"src/external/patch_cmds darling-patch_cmds 0670c7fbadfd715ac78d5476552788416cad0020"
	"src/external/pcre darling-pcre 6f67e33869a2b08da9465034c41e64e16fc7faf9"
	"src/external/perl darling-perl a65d68be2146d85928e511aabc8f3a2b05e564ba"
	"src/external/pyobjc darling-pyobjc d1a7440efe1c1090b256273ae91831186f7afde4"
	"src/external/python darling-python 4856509729cc320006a1235291e47408cd7b13ce"
	"src/external/python_modules darling-python_modules 24d01b41cb38fafc810cdd27562224c4014a4761"
	"src/external/remote_cmds darling-remote_cmds 3bb9f88724726d0d3073c04dfdc4785564113341"
	"src/external/removefile darling-removefile 3cd493871f27130f9cf64c31daab9cca2ee17726"
	"src/external/rsync darling-rsync 316c5b6b2780a28179f692f3fc0d63ebc2985705"
	"src/external/ruby darling-ruby 423f2439478d2e24d7c19b2e0ea4a67ee3e80c3d"
	"src/external/screen darling-screen 4bed52587563ede850bf9ff834567478ac1e616b"
	"src/external/security darling-security 3cfffcf2c5b5900169c964facdf42cc05c23005c"
	"src/external/shell_cmds darling-shell_cmds 5191dabbeff0aec230fc1275bae1653281ba52b2"
	"src/external/sqlite darling-sqlite 3472e2568cb7fcc25fe91af80da8d2fe884d9ac0"
	"src/external/swift darling-swift 471514f4b4985a604b192e1facac9bbc53dedad3"
	"src/external/syslog darling-syslog 36ab27964cac4affe3907a598047bd21b8958919"
	"src/external/system_cmds darling-system_cmds b01129f3dc0ecab524dbd0fd08e29ec9f0e18196"
	"src/external/tcsh darling-tcsh 7737644ec31303be19c533aab093209f3458e060"
	"src/external/text_cmds darling-text_cmds 3edd740c82b8b87c17ec9cfaae7606f6176626df"
	"src/external/top darling-top 4e27f81b5cfeef9d31d8fe5d938a80d26cca9ab5"
	"src/external/usertemplate darling-usertemplate 5f8cca97aa03ff9290d6ccc0a4d185aa1a913875"
	"src/external/vim darling-vim 7f8da1dd66fc8f0654ebfa597b6013c8cf15185a"
	"src/external/xar darling-xar 887bd4f42eb4ac9139a7f621b5811065aa86f3e3"
	"src/external/xnu darling-xnu fa29287aa2f0115271e091f1031f53c9e024005d"
	"src/external/zip darling-zip caf41ebbc3ebab0250e4d13aa42221ef91a9802c"
	"src/external/zlib darling-zlib 677de9b1c2bea1e428f56d8fc63300aa471eaf99"
	"src/external/zsh darling-zsh 4a7a6ebf6216395c7db698a4993db16e484aa54d"
)
DESCRIPTION="Translation layer for running macOS software on Linux."
HOMEPAGE="https://www.darlinghq.org/ https://github.com/darlinghq/darling"
SRC_URI="https://github.com/darlinghq/darling/archive/${DARLING_SHA}.tar.gz -> darling-${DARLING_SHA}.tar.gz"
for _sm in "${DARLING_SUBMODULES[@]}"; do
	# shellcheck disable=SC2206
	_f=( ${_sm} )
	SRC_URI+=" https://github.com/darlinghq/${_f[1]}/archive/${_f[2]}.tar.gz -> ${_f[1]}-${_f[2]}.tar.gz"
done
unset _f _sm
S="${WORKDIR}/darling-${DARLING_SHA}"

LICENSE="GPL-3 Apache-2.0 APSL-2 BSD BSD-2 ISC LGPL-2.1+ MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="metal"

# shellcheck disable=SC2016
DEPEND="
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/giflib
	media-libs/libglvnd
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libpulse
	media-libs/tiff
	media-video/ffmpeg:=
	sys-apps/dbus
	sys-fs/fuse:0
	virtual/glu
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libxkbfile
	metal? (
		media-libs/vulkan-loader
		$(llvm_gen_dep 'llvm-core/llvm:${LLVM_SLOT}')
	)
"
RDEPEND="${DEPEND}"
# shellcheck disable=SC2016
BDEPEND="
	app-alternatives/lex
	app-alternatives/yacc
	app-arch/xz-utils
	dev-util/darling-mig
	sys-devel/darling-cctools
	sys-libs/libcap
	virtual/pkgconfig
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}')
"

PATCHES=(
	"${FILESDIR}/${PN}-0001-Delete-ASM-static-libraries-before-re-archiving.patch"
	"${FILESDIR}/${PN}-0002-Disable-constant-ObjC-literals-when-the-compiler-s.patch"
	"${FILESDIR}/${PN}-0003-Add-USE_SYSTEM_CCTOOLS-and-USE_SYSTEM_MIG-options.patch"
	"${FILESDIR}/${PN}-0004-Fail-the-build-when-MIG-fails.patch"
	"${FILESDIR}/${PN}-0005-Honour-DESTDIR-in-install-steps.patch"
	"${FILESDIR}/${PN}-0006-Always-treat-the-build-as-cross-compiling.patch"
	"${FILESDIR}/${PN}-0007-Derive-OBJC_IS_DEBUG_BUILD-from-NDEBUG.patch"
	"${FILESDIR}/${PN}-0008-iridium-support-LLVM-23-s-split-branch-opcodes.patch"
	"${FILESDIR}/${PN}-0009-Honour-DESTDIR-when-renaming-install-bin.patch"
	"${FILESDIR}/${PN}-0010-Build-std-filesystem-into-libc-.1.dylib.patch"
	"${FILESDIR}/${PN}-0011-Return-results-from-semget-and-semctl.patch"
	"${FILESDIR}/${PN}-0012-Restore-the-working-directory-after-joining-the-mo.patch"
	"${FILESDIR}/${PN}-0013-Link-host-directories-into-the-prefix-at-the-same-.patch"
	"${FILESDIR}/${PN}-0014-Add-darpath-to-convert-paths-between-the-host-and-.patch"
)

FILECAPS=( cap_sys_admin+ep usr/libexec/darling/usr/sbin/fseventsd )

src_unpack() {
	unpack "darling-${DARLING_SHA}.tar.gz"
	local f sm
	for sm in "${DARLING_SUBMODULES[@]}"; do
		# shellcheck disable=SC2206
		f=( ${sm} )
		mkdir -p "${S}/${f[0]}" || die
		tar -xzf "${DISTDIR}/${f[1]}-${f[2]}.tar.gz" -C "${S}/${f[0]}" --strip-components=1 || die
	done
}

src_configure() {
	llvm_prepend_path "${LLVM_SLOT}"
	local -x CC="${CHOST}-clang" CXX="${CHOST}-clang++"
	# Most of Darling is built for the Darwin target and linked by ld64, which supports neither GNU ld
	# options nor LTO.
	filter-lto
	local -x LDFLAGS=""
	local mycmakeargs=(
		-DCOMPILE_PY2_BYTECODE=OFF
		-DDARLING_NO_CCACHE=ON
		-DENABLE_METAL="$(usex metal ON OFF)"
		-DUSE_SYSTEM_CCTOOLS=ON
		-DUSE_SYSTEM_MIG=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# Darling needs its empty directories (e.g. proc is where procfs gets mounted); Portage drops them
	local dir
	while IFS= read -r -d '' dir; do
		keepdir "${dir#"${ED}"}"
	done < <(find "${ED}/usr/libexec/darling" -type d -empty -print0 || die)
}

pkg_postinst() {
	fcaps_pkg_postinst
	if [[ -n ${REPLACING_VERSIONS} ]]; then
		elog "A running Darling container continues to use the files from before this update. Each user"
		elog "with a running container must stop it with:"
		elog "  darling shutdown"
		elog "To stop every Darling container on the system, run as root:"
		elog "  pkill -x darlingserver"
	fi
}
