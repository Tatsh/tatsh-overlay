# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {18..23} )

inherit cmake fcaps flag-o-matic llvm-r2

DARLING_SHA="003f0c0e95c560720d6102516aca64422fb7486e"
# Submodules used by the stock component set: "<path> <darlinghq repository> <commit>".
# cctools-port and bootstrap_cmds come from sys-devel/darling-cctools and dev-util/darling-mig.
DARLING_SUBMODULES=(
	"src/external/AvailabilityVersions darling-AvailabilityVersions e28c029a8fa46fa933cbf6d6d9a1c00978c5fad1"
	"src/external/BerkeleyDB darling-BerkeleyDB 1411173f0eb71f96ab6134de4e052d16acb8c673"
	"src/external/Console darling-Console b89d872125e721fdbb8edbc3236f4f0404ecee7d"
	"src/external/DSTools darling-DSTools e015256b16965ac032412f2277c608c7213c03b3"
	"src/external/DirectoryService darling-DirectoryService feb9742f574ab812a210634fd3997f19b645095f"
	"src/external/Heimdal darling-Heimdal 3dfb09751063d6c144143edfb2ef13aa3e8c57de"
	"src/external/IOKitTools darling-IOKitTools df58be2f134f7adbdd3c760a165ad3501ee82fb5"
	"src/external/IOKitUser darling-iokituser 6f58ca0206a693a11ff94c66e17e57954d565ef3"
	"src/external/IOKitUser/darling/submodules/IOGraphics darling-IOGraphics 905186151d713259296f3ae9458195a7097ea323"
	"src/external/IOKitUser/darling/submodules/IOHIDFamily darling-IOHIDFamily 189e98e32092d5f5a2c365cc85fd36ac7da2d371"
	"src/external/IONetworkingFamily darling-IONetworkingFamily 28afb431947b8e8dbbb120db7632ba6de229bf23"
	"src/external/IOStorageFamily darling-iostoragefamily 33178aef923d9c99f1819db2ada253054f4dd812"
	"src/external/Libinfo darling-Libinfo 7e923de22d29cc300302a2ec8b6a1c64b8a76014"
	"src/external/MITKerberosShim darling-MITKerberosShim 39c014d0c54f9ae922be0d697aa6cc1b19c117b6"
	"src/external/OpenCombine OpenCombine 1c6f02c7ed8140c0ba7a783aaddb6e0685a0037b"
	"src/external/OpenDirectory darling-opendirectory 3adff13b0887e8915b8de2e4c827a96cae29fe45"
	"src/external/OpenLDAP darling-openldap 3b15390bbcad8234aabb3246b0552105b17118d0"
	"src/external/SecurityTokend darling-SecurityTokend c826860db4061667af6f0c3aa55282aab0924e1a"
	"src/external/SmartCardServices darling-SmartCardServices ec53ce56972565047a716ab166176f203f520393"
	"src/external/TextEdit darling-TextEdit 65cedd44659954d17b07d3087c756b8a693c92d8"
	"src/external/WTF darling-WTF 88a36e496a6f285a9e15140c2c431b817bae353b"
	"src/external/adv_cmds darling-adv_cmds 56dcf5ebeb822650d7929f666be58544b2391f6e"
	"src/external/apr darling-apr 5aa6eba89e497a67f1b9db7842371141a8616674"
	"src/external/architecture darling-architecture 63162c4744e9bd07673d4c29f8825f105f670e44"
	"src/external/awk darling-awk 5d46e527461bce5fa10b89320a1c6ce5f1ae38b6"
	"src/external/bash darling-bash b15a7b9f57bc62d99b965e71b6aadda9a8e49b75"
	"src/external/basic_cmds darling-basic_cmds b1ed4f0f6a981590542071d8b36535cf3e441be0"
	"src/external/bc darling-bc 666e93c8223f509ae9c3c69e3c20af45d49a749c"
	"src/external/bind9 darling-bind9 7542d50b3087edb4a46a2bdb11ba75034aa2bffa"
	"src/external/bomutils bomutils c2796cb074aa81e122b16a42164b62945de9a293"
	"src/external/bsm darling-bsm bec0dd61bb07469d1fcb3985822d350abc9934f7"
	"src/external/bzip2 darling-bzip2 484761f668be282a9798137a986b557512e67f5f"
	"src/external/cctools darling-cctools 8777b6dc7c4de87087c028e17db075795b3684d3"
	"src/external/cfnetwork darling-cfnetwork 1e10977f9299f323543c1457bd34ec6d8381163a"
	"src/external/cocotron darling-cocotron 9909db22c700ba6e30457e63df45a6e64fe2b6dc"
	"src/external/commoncrypto darling-commoncrypto 2434540f41a5f94f149cfddd67da244961b716e5"
	"src/external/compiler-rt darling-compiler-rt 76ea5534168b003918912c708328fa16ec97459b"
	"src/external/configd darling-configd 397d76b9cbbb1f8c595cc48a4132f4fcc4c51738"
	"src/external/copyfile darling-copyfile 293e6fad9015f4d682b9cc4e366b516b1e640703"
	"src/external/corecrypto darling-corecrypto bef49a923d2a4565222f742f26b54a91f7cb3015"
	"src/external/corefoundation darling-corefoundation f147da10209a8f5bcca0bc66ae691d217383473d"
	"src/external/corefoundation/submodules/swift-corelibs-foundation darling-swift-corelibs-foundation efb3637c5e79057fc13c57dd3c88a7febbd1e781"
	"src/external/coretls darling-coretls b61a4f075726e7d5ef4652033f8d7b829c008d06"
	"src/external/crontabs darling-crontabs 70623f4f192da75364ed854d8bb03ed13a4a91f5"
	"src/external/csu darling-Csu 93b25cf0930a727b44fa50893bffd71056ad032f"
	"src/external/cups darling-cups 49fbfd5ee97af72ff7adfe9fb4586aca4fc73cfd"
	"src/external/curl darling-curl 098513685a84ac6a7c1500ef448017b265694e20"
	"src/external/darling-dmg darling-dmg a63693ef4c0f1cc0a054f85d3757d8892765aa99"
	"src/external/darlingserver darlingserver 3d34adcbbc1087920f7a81490bf5dcee4d15118d"
	"src/external/dbuskit darling-dbuskit c1333df9dcfee1fcbe2a4ada598d6109847d9418"
	"src/external/doc_cmds darling-doc_cmds 60c6a2b858abe1f27b441f479aad2b0a9d0f9ba2"
	"src/external/dtrace darling-dtrace fd2a404c772e8ce1d29f210032e9831fa845f688"
	"src/external/dyld darling-dyld c2fb5d3cbc1cf9c07ee4fe1e754a36090f83c3ea"
	"src/external/energytrace darling-energytrace e277fcfd430ddab2d8b52187cf480f2857629104"
	"src/external/expat darling-expat 668106ec49660a591b7ec73408df4b9b7c46f8f2"
	"src/external/file darling-file c6ee65265d253d24b1a496f8ca54b5e449fe108c"
	"src/external/file_cmds darling-file_cmds 92fa2c276519b7d9446e8f5fb975081fdbfd04df"
	"src/external/files darling-files 1c45a50ae0d6ca5bbb8b01d2b588f52bc0e39263"
	"src/external/fmdb fmdb ad2fdd660d02c24b262d64d7d23d3d4645768f44"
	"src/external/foundation darling-foundation 625159b1fbdf5aa3438c937d3a70edef04db83ef"
	"src/external/gnudiff darling-gnudiff ae0ab716658296164a032be7406f082cdc31c954"
	"src/external/gpatch darling-gpatch 49acc897e8cb832a26b7ac4d2f7db51d3c6ba037"
	"src/external/grep darling-grep 62d70fada3a01de87aff927a86b8df0f7f2a837a"
	"src/external/groff darling-groff 10dd5a6be4915a99065bc15dfc6b6b1e9e1a2714"
	"src/external/icu darling-icu e5e692047b766fc1acce2ea34beeabd3c2889ae6"
	"src/external/installer darling-installer 68f882d206903d7c135c49b93fe51c9dffbf0c10"
	"src/external/iokitd darling-iokitd 3409e3b3ee1f7429e79bb0641850d260f6986524"
	"src/external/keymgr darling-keymgr 43b4230aec2e9018b0ffd3069b8b23a34ba257fb"
	"src/external/less darling-less a6bc77c8e72aaa35da92b903172a70eaa4ef78fa"
	"src/external/libarchive darling-libarchive 998d739c602a1b35e2377ec9161e9c13d1d8604d"
	"src/external/libauto darling-libauto 2be7312b25736a8e9fc12058d63cbb79eb5f4e25"
	"src/external/libc darling-Libc c0a1f787c149202896ef30ec2676bcea2c25743c"
	"src/external/libclosure darling-libclosure d08382015303cce438df49e738be5d9f66e8092d"
	"src/external/libcxx darling-libcxx 061279ebb3944b11bbbc76ae7fd77077841f8c74"
	"src/external/libcxxabi darling-libcxxabi f49cc5d15c1be9f2c185bc9ec82d4c03d31d183f"
	"src/external/libdispatch darling-libdispatch 15861eab00bd0479a263be4688aa20b2b5be1013"
	"src/external/libedit darling-libedit f9b44b8541614e33b09451fc2847f7e30bfb9b70"
	"src/external/libffi darling-libffi 8acf2b465f9606945652047f706f4282ad058546"
	"src/external/libiconv darling-libiconv 0d6f47d33a7cc97e468e864099fff74875b41937"
	"src/external/libkqueue darling-libkqueue 72ad4ea26a02638c9ef2bae8c1a75fbf52210027"
	"src/external/liblzma darling-liblzma 3a17a96ee376c4b8006a3eed6fee4e92c3d903cf"
	"src/external/libmalloc darling-libmalloc 8cfc162ed4445e56afdad5a4d49c47b9a810cfd0"
	"src/external/libnetwork darling-libnetwork 2ad599127155afed67146253b504c44b2acd6725"
	"src/external/libnotify darling-Libnotify c3c3b83d4ae7aca5aa54c4fee29ac98d7044bc4c"
	"src/external/libpcap darling-libpcap bd2c4e2e4abfee596fb88a25082db5ddda60f490"
	"src/external/libplatform darling-libplatform a3ae1aabcb16a3b8352f317b11fd86a5c2111eed"
	"src/external/libpthread darling-libpthread f0ec3a35342741bfb32d308ebc3e943ba9af0c52"
	"src/external/libresolv darling-libresolv 03e65dc1181401c28921e095b81399ae0b8a2d14"
	"src/external/libressl-2.2.9 darling-libressl f127dfef1675c4c664c5b6e504170838b0c1732a"
	"src/external/libressl-2.5.5 darling-libressl a02f54936f7d3dbbe6d8711aca114f93af6da151"
	"src/external/libressl-2.6.5 darling-libressl 17ca3236ec81827fec37cb5badd5e43019e63a84"
	"src/external/libressl-2.8.3 darling-libressl 59229b26fa6d9c3753194fcbfaa1f529900825dd"
	"src/external/libressl-3.3.6 darling-libressl d613d5d9ce90f99e48fecd888fc3373684dd7647"
	"src/external/librpcsvc darling-librpcsvc 0cc1d42e53c61446616719597e96b29aeda51eb3"
	"src/external/libstdcxx darling-libstdcxx 73eb757fe23170c372bef17d6de41787c1271c80"
	"src/external/libsystem darling-Libsystem 7a661e5807c950d7f8614911579ca6101a29fc96"
	"src/external/libtelnet darling-libtelnet 1ebd4eef48d06e6411ed2a0f60ba5d3fce5ab455"
	"src/external/libtrace darling-libtrace 018e50a845bee7acf687dcdc87a46d94433f4df3"
	"src/external/libunwind darling-libunwind 6c3f50b4ff7ac274d1148f98cdbf626771294457"
	"src/external/libutil darling-libutil e3782a467c248c8d181aba1200ee0642abb65baf"
	"src/external/libxml2 darling-libxml2 d4f2967c8ca84a23a886978098c0520fe2963b92"
	"src/external/libxpc darling-libxpc a4f53a7839bedf744d31432b5a412afb465ba33d"
	"src/external/libxslt darling-libxslt 50d22bd5b761a1885009b690e48d858ff73e768b"
	"src/external/lzfse lzfse 451f291743bb919cb1b78ced4110402fca52cf97"
	"src/external/mDNSResponder darling-mDNSResponder 7e38ef562b4f3d41bffabb3e30d844d8042d3bbd"
	"src/external/mail_cmds darling-mail_cmds 4afbcf4b9b8a6c33acaf7e9025e51ce72b3725a7"
	"src/external/man darling-man 9af6690f3c7c3c713bb0a20ba1163d3c4278257d"
	"src/external/metal darling-metal 1b6727532392c83abe81a56a7bba1f1f5989be76"
	"src/external/metal/deps/indium indium 7e029471b376c35bf5b82dd71e12ad6d4ca02910"
	"src/external/metal/deps/mslc mslc 86c987631d9b790c920741680bf03be82aa7032e"
	"src/external/misc_cmds darling-misc_cmds 85b24ec0e2625d75e7ee75b597b9134a49d18b1f"
	"src/external/nano darling-nano 7514f5f1115fffedd8fc2095107ca86ff82c54d6"
	"src/external/ncurses darling-ncurses 4cc72a9a1bce214593c10811b0154a8d51db0239"
	"src/external/netcat darling-netcat fd29177d56d84f88406e33784c327ebabfe7be58"
	"src/external/network_cmds darling-network_cmds 9a0a90e2021ecdde91986b91f65a236eda158023"
	"src/external/nghttp2 darling-nghttp2 1a1853837b4350d4393bd25e1e4cb6018ab2d918"
	"src/external/objc4 darling-objc4 a68efe2ba2159e84e1b9a52b5b34f993567c17b2"
	"src/external/openal-soft openal-soft 21fb637723111dc156680627951845576ceec7ad"
	"src/external/openjdk darling-openjdk 5a541c1844a9508e48b3addaf2d38775683abb38"
	"src/external/openpam darling-openpam 8362545bac04032fcf59287cd66e6f4662a3692b"
	"src/external/openpam/darling/submodules/pam_modules darling-pam_modules 241bbee0da845d1dfebc747b16a62aaed22f165b"
	"src/external/openssh darling-openssh 7030f223c5fe24b97f89da65cf83a10967839eed"
	"src/external/openssl darling-openssl 6507175c89b73b2838fccde134d400258d2efe1f"
	"src/external/openssl_certificates darling-openssl_certificates 1606a45e245632c756774b1917d3f7553702e9b4"
	"src/external/passwordserver_sasl darling-passwordserver_sasl 45019fa25adf5ad5713d9e39df3b72e420dccc96"
	"src/external/patch_cmds darling-patch_cmds 0670c7fbadfd715ac78d5476552788416cad0020"
	"src/external/pcre darling-pcre 6f67e33869a2b08da9465034c41e64e16fc7faf9"
	"src/external/perl darling-perl 5ddb51e52b76993de2aa2d36732fc66f03c5d4b9"
	"src/external/pyobjc darling-pyobjc d1a7440efe1c1090b256273ae91831186f7afde4"
	"src/external/python darling-python 24800cec23749653800350b765f5c90d0acf9601"
	"src/external/python_modules darling-python_modules 24d01b41cb38fafc810cdd27562224c4014a4761"
	"src/external/remote_cmds darling-remote_cmds 3bb9f88724726d0d3073c04dfdc4785564113341"
	"src/external/removefile darling-removefile 3cd493871f27130f9cf64c31daab9cca2ee17726"
	"src/external/rsync darling-rsync 316c5b6b2780a28179f692f3fc0d63ebc2985705"
	"src/external/ruby darling-ruby 95af737d07d76446432bb15cbf3ec43c7ff7289f"
	"src/external/screen darling-screen 4bed52587563ede850bf9ff834567478ac1e616b"
	"src/external/security darling-security 84c0a3e1d25caa4cd370e850813aa527c31a2d12"
	"src/external/shell_cmds darling-shell_cmds 219550b9509c704c99657bc3239b0022a6bca9b4"
	"src/external/sqlite darling-sqlite 70794d51861d4c4e09e73a7bb5b9e2cf14f9522e"
	"src/external/stanford-srp stanford-srp 953671e1600801bf4133f64f185080e7a60ac00e"
	"src/external/swift darling-swift 59dcc61351b39ddc8a75b96d41688fdb7e48f982"
	"src/external/swift-cmark swift-cmark 924936d0427cb25a61169739a7660230bffa6ea6"
	"src/external/swift-foundation swift-foundation d72ae913dc24638420d319df8d6805b8b7f55592"
	"src/external/syslog darling-syslog 55aab056c72d2505268f899a08af1c556675433a"
	"src/external/system_cmds darling-system_cmds e22d641c2b96a14d5e3f880ddaa18ac2d43ccaec"
	"src/external/tcsh darling-tcsh 7737644ec31303be19c533aab093209f3458e060"
	"src/external/text_cmds darling-text_cmds 3edd740c82b8b87c17ec9cfaae7606f6176626df"
	"src/external/top darling-top 4e27f81b5cfeef9d31d8fe5d938a80d26cca9ab5"
	"src/external/usertemplate darling-usertemplate 5f8cca97aa03ff9290d6ccc0a4d185aa1a913875"
	"src/external/vim darling-vim 7f8da1dd66fc8f0654ebfa597b6013c8cf15185a"
	"src/external/xar darling-xar 887bd4f42eb4ac9139a7f621b5811065aa86f3e3"
	"src/external/xnu darling-xnu a2364b49ef86082648286a3bc2a582dc3ac2440c"
	"src/external/zip darling-zip caf41ebbc3ebab0250e4d13aa42221ef91a9802c"
	"src/external/zlib darling-zlib 5e2eb97280972b2845e5d300d93a72fe8df7d70c"
	"src/external/zsh darling-zsh e1a4d4f4d228e97e6e92e1e87832a39339717ef8"
)
DESCRIPTION="Translation layer for running macOS software on Linux"
HOMEPAGE="https://www.darlinghq.org/ https://github.com/darlinghq/darling"
SRC_URI="https://github.com/darlinghq/darling/archive/${DARLING_SHA}.tar.gz -> darling-${DARLING_SHA}.tar.gz"
for _sm in "${DARLING_SUBMODULES[@]}"; do
	# shellcheck disable=SC2206
	_f=( ${_sm} )
	SRC_URI+=" https://github.com/darlinghq/${_f[1]}/archive/${_f[2]}.tar.gz -> ${_f[1]}-${_f[2]}.tar.gz"
done
unset _f _sm
# GitHub archives carry Git LFS pointers, and darling's LFS server only serves objects to
# clients that send the LFS Accept header.
SRC_URI+=" https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/darling-icu-icudt78l-cd04af74.dat.xz"
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
	"${FILESDIR}/${PN}-0003-Add-USE_SYSTEM_CCTOOLS-and-USE_SYSTEM_MIG-options.patch"
	"${FILESDIR}/${PN}-0012-Restore-the-working-directory-after-joining-the-mo.patch"
	"${FILESDIR}/${PN}-0013-Link-host-directories-into-the-prefix-at-the-same-.patch"
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
	cp "${DISTDIR}/darling-icu-icudt78l-cd04af74.dat.xz" \
		"${S}/src/external/icu/icuSources/data/out/icudt78l.dat.xz" || die
}

src_prepare() {
	# JavaScriptCore is only built with COMPONENT_jsc and is not fetched. Its SDK header link would
	# dangle and fail the configure-time SDK check.
	rm "${S}/framework-include/JavaScriptCore" || die
	# The host-side ad-hoc signing checker needs cctools-port's Mach-O headers, and cctools-port
	# is not fetched (USE_SYSTEM_CCTOOLS). It is a test program and is not installed.
	# shellcheck disable=SC2016
	sed -e '/add_subdirectory(${CMAKE_SOURCE_DIR}\/tests\/adhoc-sign /d' -i src/CMakeLists.txt || die
	cmake_src_prepare
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
