# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	aes@0.9.3
	aho-corasick@1.1.5
	anyhow@1.0.104
	ascii@1.1.0
	autocfg@1.5.1
	base64@0.23.1
	bitflags@2.13.2
	block-buffer@0.12.1
	block2@0.6.2
	bumpalo@3.20.3
	bytes@1.12.1
	cairo-rs@0.20.12
	cairo-sys-rs@0.20.10
	cc@1.9.0
	cfg-expr@0.20.10
	cfg-if@1.0.5
	cfg_aliases@0.2.2
	chacha20@0.10.2
	chunked_transfer@1.5.0
	cipher@0.5.2
	const-oid@0.10.2
	cookie@0.18.2
	cookie_store@0.22.1
	cpubits@0.1.1
	cpufeatures@0.3.1
	crc32fast@1.5.2
	crossbeam-channel@0.5.17
	crossbeam-deque@0.8.8
	crossbeam-epoch@0.9.21
	crossbeam-utils@0.8.23
	crypto-common@0.2.2
	deranged@0.5.9
	digest@0.11.3
	dispatch2@0.3.1
	displaydoc@0.2.7
	document-features@0.2.12
	either@1.19.0
	equivalent@1.0.3
	errno@0.3.14
	fastrand@2.5.0
	field-offset@0.3.6
	find-msvc-tools@0.1.15
	flate2@1.1.10
	form_urlencoded@1.2.2
	futures-channel@0.3.34
	futures-core@0.3.34
	futures-executor@0.3.34
	futures-io@0.3.34
	futures-macro@0.3.34
	futures-task@0.3.34
	futures-util@0.3.34
	gdk-pixbuf-sys@0.20.10
	gdk-pixbuf@0.20.10
	gdk4-sys@0.9.6
	gdk4@0.9.6
	getrandom@0.2.17
	getrandom@0.4.3
	gio-sys@0.20.10
	gio@0.20.12
	glib-macros@0.20.12
	glib-sys@0.20.10
	glib@0.20.12
	gobject-sys@0.20.10
	graphene-rs@0.20.10
	graphene-sys@0.20.10
	gsk4-sys@0.9.6
	gsk4@0.9.6
	gtk4-macros@0.9.5
	gtk4-sys@0.9.6
	gtk4@0.9.7
	h8-asm@0.5.0
	hashbrown@0.17.1
	heck@0.5.0
	http@1.5.0
	httparse@1.10.1
	httpdate@1.0.3
	hybrid-array@0.4.15
	icu_collections@2.3.0
	icu_locale_core@2.3.0
	icu_normalizer@2.3.0
	icu_normalizer_data@2.3.0
	icu_properties@2.3.0
	icu_properties_data@2.3.0
	icu_provider@2.3.1
	idna@1.1.0
	idna_adapter@1.2.2
	indexmap@2.14.2
	inout@0.2.5
	isolang@2.4.0
	itoa@1.0.18
	lazy_static@1.5.1
	libadwaita-sys@0.7.2
	libadwaita@0.7.2
	libc@0.2.191
	libmimalloc-sys@0.1.49
	linux-raw-sys@0.12.1
	litemap@0.8.3
	litrs@1.0.1
	log@0.4.34
	matchers@0.2.0
	memchr@2.8.3
	memoffset@0.9.1
	mimalloc@0.1.52
	miniz_oxide@0.9.1
	nix@0.31.3
	nu-ansi-term@0.50.3
	num-bigint@0.5.1
	num-conv@0.2.2
	num-integer@0.1.47
	num-traits@0.2.19
	objc2-app-kit@0.3.2
	objc2-cloud-kit@0.3.2
	objc2-core-data@0.3.2
	objc2-core-foundation@0.3.2
	objc2-core-graphics@0.3.2
	objc2-core-image@0.3.2
	objc2-core-text@0.3.2
	objc2-core-video@0.3.2
	objc2-encode@4.1.0
	objc2-foundation@0.3.2
	objc2-io-surface@0.3.2
	objc2-quartz-core@0.3.2
	objc2-user-notifications@0.3.2
	objc2@0.6.5
	once_cell@1.21.4
	pango-sys@0.20.10
	pango@0.20.12
	percent-encoding@2.3.2
	phf@0.11.3
	phf_shared@0.11.3
	pin-project-lite@0.2.17
	pioneer-optical@0.12.4
	pkg-config@0.3.34
	potential_utf@0.1.6
	powerfmt@0.2.1
	proc-macro-crate@3.5.0
	proc-macro2@1.0.107
	quote@1.0.47
	r-efi@6.0.0
	rand@0.10.3
	rand_core@0.10.1
	rayon-core@1.13.0
	rayon@1.12.0
	regex-automata@0.4.18
	regex-syntax@0.8.11
	ring@0.17.14
	roxmltree@0.21.1
	rustc_version@0.4.1
	rustix@1.1.5
	rustls-pki-types@1.15.1
	rustls-webpki@0.103.16
	rustls@0.23.46
	semver@1.0.28
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_json@1.0.154
	serde_spanned@1.1.2
	sha1@0.11.0
	sha2@0.11.1
	sharded-slab@0.1.7
	shlex@2.0.1
	simd-adler32@0.3.10
	siphasher@1.0.4
	slab@0.4.12
	smallvec@1.16.3
	socket2@0.6.5
	stable_deref_trait@1.2.1
	subtle@2.6.1
	symlink@0.1.0
	syn@2.0.119
	syn@3.0.9
	synstructure@0.14.0
	system-deps@7.0.8
	target-lexicon@0.13.5
	tempfile@3.27.0
	thiserror-impl@2.0.21
	thiserror@2.0.21
	thread_local@1.1.10
	time-core@0.1.9
	time-macros@0.2.32
	time@0.3.55
	tiny_http@0.12.0
	tinystr@0.8.4
	toml@1.1.8+spec-1.1.0
	toml_datetime@1.1.2+spec-1.1.0
	toml_edit@0.25.17+spec-1.1.0
	toml_parser@1.1.5+spec-1.1.0
	toml_writer@1.1.3+spec-1.1.0
	tracing-appender@0.2.5
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing-log@0.2.0
	tracing-serde@0.2.0
	tracing-subscriber@0.3.23
	tracing@0.1.44
	typed-path@0.12.3
	typenum@1.20.1
	unicode-ident@1.0.27
	untrusted@0.9.0
	ureq-proto@0.6.5
	ureq@3.5.0
	url@2.5.8
	utf8-zero@0.8.1
	utf8_iter@1.0.4
	valuable@0.1.1
	version-compare@0.2.1
	version_check@0.9.5
	wasi@0.11.1+wasi-snapshot-preview1
	webpki-roots@1.0.10
	windows-collections@0.3.2
	windows-core@0.62.2
	windows-future@0.3.2
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.2.1
	windows-numerics@0.3.1
	windows-result@0.4.1
	windows-strings@0.5.1
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows-threading@0.2.1
	windows@0.62.2
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@1.0.4
	winsafe@0.0.29
	writeable@0.6.4
	yoke-derive@0.8.4
	yoke@0.8.3
	zerofrom-derive@0.1.8
	zerofrom@0.1.8
	zeroize@1.9.1
	zeroize_derive@1.5.0
	zerotrie@0.2.5
	zerovec-derive@0.11.6
	zerovec@0.11.8
	zip@9.0.5
	zlib-rs@0.6.8
	zmij@1.0.23
	zopfli@0.8.4
"

# The freemkv crates are not on crates.io; upstream pulls them from git tags.
declare -A GIT_CRATES=(
	[freemkv-engine]='https://github.com/freemkv/freemkv-engine;564de784d06b3052dd85fec95e9a43bf9b7158da;freemkv-engine-%commit%'
	[freemkv-i18n]='https://github.com/freemkv/freemkv-i18n;4b37db08599b07f0cf654b1e5c6c7cddd1d8688f;freemkv-i18n-%commit%'
	[freemkv-keysources]='https://github.com/freemkv/freemkv-keysources;275fefac617d1f0b8e74a9cc6dc8d3531f42da2a;freemkv-keysources-%commit%'
	[freemkv-unlock]='https://github.com/freemkv/freemkv-unlock;57df3649643689ab97e6ea54c8319b72d30b2d11;freemkv-unlock-%commit%'
	[libfreemkv]='https://github.com/freemkv/libfreemkv;927b301c73ece1be151cca3187fd68039e4192e8;libfreemkv-%commit%'
)

RUST_MIN_VER="1.98.1"

inherit cargo desktop xdg

DESCRIPTION="Open source 4K UHD, Blu-ray, HD DVD and DVD backup tool"
HOMEPAGE="https://github.com/freemkv/freemkv"
SRC_URI="https://github.com/freemkv/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CDLA-Permissive-2.0
	ISC MIT Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui server"

DEPEND="gui? (
		dev-libs/glib:2
		gui-libs/gtk:4
		gui-libs/libadwaita:1
	)"
RDEPEND="${DEPEND}"
BDEPEND="gui? ( virtual/pkgconfig )"

src_prepare() {
	# Upstream redirects the freemkv crates to git tags with [patch.crates-io]. Cargo cannot
	# patch a patch, so point the redirect at the unpacked GIT_CRATES instead.
	local crate commit
	for crate in "${!GIT_CRATES[@]}"; do
		commit="${GIT_CRATES[${crate}]#*;}"
		commit="${commit%%;*}"
		sed -i "/^${crate} = { git = /c ${crate} = { path = \"${WORKDIR}/${crate}-${commit}\" }" \
			Cargo.toml || die
	done
	sed -i '/^source = "git+https:\/\/github.com\/freemkv\//d' Cargo.lock || die
	default
}

src_configure() {
	local myfeatures=()
	use gui && myfeatures+=( gui )
	use server && myfeatures+=( server )
	cargo_src_configure
}

src_install() {
	cargo_src_install
	if use gui; then
		# Windows-only windowed image; an empty main elsewhere. freemkv itself opens the app.
		rm "${ED}/usr/bin/freemkv-gui" || die
		domenu packaging/flatpak/org.freemkv.FreeMKV.desktop
		newicon -s scalable res/freemkv-icon.svg org.freemkv.FreeMKV.svg
		insinto /usr/share/metainfo
		doins packaging/flatpak/org.freemkv.FreeMKV.metainfo.xml
	fi
	einstalldocs
}
