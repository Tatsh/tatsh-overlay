# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit font

DESCRIPTION="Google's font family that aims to support all the world's languages"
HOMEPAGE="https://www.google.com/get/noto/ https://github.com/notofonts/notofonts.github.io"

COMMIT="af1e7c8e424971bac3927b0a7084625f79d186e5"
SRC_URI="https://github.com/notofonts/notofonts.github.io/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~sparc ~x86"
# Extra allows to optionally reduce disk usage even returning to tofu
# issue as described in https://www.google.com/get/noto/
IUSE="brahmi music coptic cuneiform cypriot deseret duployan linear
	+display +symbols runic phagspa pau-cin-hau old-arabian hieroglyphs
	+mono ancient +extra"
IUSE_IL10N=( ar ban bax ber bku blt bn bo bsq bug bya ccp chr cja cmr dv
	eo ff gu he hi hoc hy ii ja jv ka khb km kn ko kv lo mai men mjl ml mn mni
	mww my new nod nqo or osa pa rej sa sat saz sd si so sq srb su syc syl ta
	tbw te th tl tmh ur vai zh-CN zh-TW iu hnn bho eky lep lif lis tbw skr mr
	pa tmh )
for lang in "${IUSE_IL10N[@]}"; do
	IUSE="${IUSE} l10n_${lang}"
done

RDEPEND="l10n_zh-CN? ( media-fonts/noto-cjk )
	l10n_zh-TW? ( media-fonts/noto-cjk )
	l10n_ja? ( media-fonts/noto-cjk )
	l10n_ko? ( media-fonts/noto-cjk )"
RESTRICT="binchecks strip"

S="${WORKDIR}/${PN}fonts.github.io-${COMMIT}"

FONT_SUFFIX="ttf"
FONT_CONF=(
	# From ArchLinux
	"${FILESDIR}/66-noto-serif.conf"
	"${FILESDIR}/66-noto-mono.conf"
	"${FILESDIR}/66-noto-sans.conf"
)

src_prepare() {
	! use mono && find fonts -iname '*mono*.ttf' -delete
	! use hieroglyphs && find fonts -iname '*hieroglyphs*.ttf' -delete
	! use l10n_pa && find fonts -iname '*mahajani*.ttf' -delete
	! use l10n_mr && find fonts -iname '*modi*.ttf' -delete
	! use l10n_skr && find fonts -iname '*multani*.ttf' -delete
	! use old-arabian && find fonts -iname '*old*arabian*.ttf' -delete
	! use pau-cin-hau && find fonts -iname '*paucinhau*.ttf' -delete
	! use phagspa && find fonts -iname '*phagspa*.ttf' -delete
	! use runic && find fonts -iname '*runic*.ttf' -delete
	! use symbols && find fonts -iname '*symbols*.ttf' -delete
	! use l10n_tbw && find fonts -iname '*tagbanwa*.ttf' -delete
	! use display && find fonts -iname '*display*.ttf' -delete
	! use l10n_lis && find fonts -iname '*lisu*.ttf' -delete
	! use linear && find fonts -iname '*linear*.ttf' -delete
	! use l10n_lif && find fonts -iname '*limbu*.ttf' -delete
	! use l10n_lep && find fonts -iname '*lepcha*.ttf' -delete
	! use l10n_bho && find fonts -iname '*kaithi*' -delete
	! use l10n_eky && find fonts -iname '*kayahli*' -delete
	! use brahmi && find fonts -iname '*brahmi*.ttf' -delete
	! use l10n_iu && find fonts -iname '*canadianaboriginal*.ttf' -delete
	! use l10n_hnn && find fonts -iname '*hanunoo*.ttf' -delete
	! use coptic && find fonts -iname '*coptic*.ttf' -delete
	! use cuneiform && find fonts -iname '*cuneiform*.ttf' -delete
	! use cypriot && find fonts -iname '*cypriot*.ttf' -delete
	! use deseret && find fonts -iname '*deseret*.ttf' -delete
	! use duployan && find fonts -iname '*duployan*.ttf' -delete
	! use l10n_ar && find fonts -iname '*arabic*.ttf' -delete
	! use l10n_ff && find fonts -iname '*adlam*.ttf' -delete
	! use l10n_hy && find fonts -iname '*armenian*.ttf' -delete
	! use l10n_bax && find fonts -iname '*bamum*.ttf' -delete
	! use l10n_bsq && find fonts -iname '*bassavah*.ttf' -delete
	! use l10n_bya && find fonts -iname '*batak*.ttf' -delete
	! use l10n_bn && find fonts -iname '*bengali*.ttf' -delete
	! use l10n_bug && find fonts -iname '*buginese*.ttf' -delete
	! use l10n_bku && find fonts -iname '*buhid*.ttf' -delete
	! use l10n_sq && find fonts '(' -iname '*albanian*.ttf' -o \
		-iname '*elbasan*.ttf' ')' -delete
	! use l10n_ccp && find fonts -iname '*chakma*.ttf' -delete
	! use l10n_cja && find fonts -iname '*cham*.ttf' -delete
	! use l10n_chr && find fonts -iname '*cherokee*.ttf' -delete
	! use l10n_ur && find fonts -iname '*urdu*.ttf' -delete
	! use l10n_pa && find fonts -iname '*gurmukhi*.ttf' -delete
	! use l10n_he && find fonts -iname '*hebrew*.ttf' -delete
	! use l10n_jv && find fonts -iname '*javanese*.ttf' -delete
	! use l10n_kn && find fonts -iname '*kannada*.ttf' -delete
	! use l10n_km && find fonts -iname '*khmer*.ttf' -delete
	! use l10n_sd && find fonts -iname '*khudawadi*.ttf' -delete
	! use l10n_ml && find fonts -iname '*malayalam*.ttf' -delete
	! use l10n_mni && find fonts -iname '*meetei*.ttf' -delete
	! use l10n_men && find fonts -iname '*mende*.ttf' -delete
	! use l10n_mn && find fonts -iname '*mongolian*.ttf' -delete
	! use l10n_cmr && find fonts -iname '*mro*.ttf' -delete
	! use l10n_khb && find fonts -iname '*tail*.ttf' -delete
	! use l10n_new && find fonts -iname '*newa*.ttf' -delete
	! use l10n_nqo && find fonts -iname '*nko*.ttf' -delete
	! use l10n_sat && find fonts -iname '*olchiki*.ttf' -delete
	! use l10n_kv && find fonts -iname '*oldpermic*.ttf' -delete
	! use l10n_or && find fonts -iname '*oriya*.ttf' -delete
	! use l10n_osa && find fonts -iname '*osage*.ttf' -delete
	! use l10n_so && find fonts -iname '*osmanya*.ttf' -delete
	! use l10n_mww && find fonts '(' -iname '*pahawhhmong*.ttf' -o \
		-iname '*miao*.ttf' ')' -delete
	! use l10n_rej && find fonts -iname '*rejang*.ttf' -delete
	! use l10n_saz && find fonts -iname '*saurashtra*.ttf' -delete
	! use l10n_sa && find fonts '(' -iname '*sharada*.ttf' -o \
		-iname '*bhaiksuki*.ttf' -o \
		-iname '*kharoshthi*.ttf' -o \
		-iname '*nandinagari*.ttf' -o \
		-iname '*grantha*.ttf' ')' -delete
	! use l10n_eo && find fonts -iname '*shavian*.ttf' -delete
	! use l10n_si && find fonts -iname '*sinhala*.ttf' -delete
	! use l10n_srb && find fonts -iname '*sorasompeng*.ttf' -delete
	! use l10n_su && find fonts -iname '*sundanese*.ttf' -delete
	! use l10n_syl && find fonts -iname '*sylotinagri*.ttf' -delete
	! use l10n_syc && find fonts -iname '*syriac*.ttf' -delete
	! use l10n_tl && find fonts -iname '*tagalog*.ttf' -delete
	! use l10n_tbw && find fonts -iname '*tagbanawa*.ttf' -delete
	! use l10n_nod && find fonts -iname '*taitham*.ttf' -delete
	! use l10n_blt && find fonts -iname '*taiviet*.ttf' -delete
	! use l10n_mjl && find fonts -iname '*takri*.ttf' -delete
	! use l10n_ta && find fonts -iname '*tamil*.ttf' -delete
	! use l10n_dv && find fonts -iname '*thaana*.ttf' -delete
	! use l10n_th && find fonts -iname '*thai*.ttf' -delete
	! use l10n_bo && find fonts -iname '*tibetan*.ttf' -delete
	! use l10n_ber && find fonts -iname '*tifinagh*.ttf' -delete
	! use l10n_mai && find fonts -iname '*tirhuta*.ttf' -delete
	! use l10n_vai && find fonts -iname '*vai*.ttf' -delete
	! use l10n_hoc && find fonts -iname '*warangciti*.ttf' -delete
	! use l10n_ii && find fonts -iname '*yi*.ttf' -delete
	! use ancient && find fonts '(' \
		-iname '*marchen*.ttf' -o \
		-iname '*meroitic*.ttf' -o \
		-iname '*lydian*.ttf' -o \
		-iname '*ahom*.ttf' -o \
		-iname '*lycian*.ttf' -o \
		-iname '*glagolitic*.ttf' -o \
		-iname '*aramaic*.ttf' -o \
		-iname '*hatran*.ttf' -o \
		-iname '*mandaic*.ttf' -o \
		-iname '*palmyrene*.ttf' -o \
		-iname '*avestan*.ttf' -o \
		-iname '*ethiopic*.ttf' -o \
		-iname '*gothic*.ttf' -o \
		-iname '*olditalic*.ttf' -o \
		-iname '*samaritan*.ttf' -o \
		-iname '*oldhungarian*.ttf' -o \
		-iname '*oldturkic*.ttf' -o \
		-iname '*psalterpahlavi*.ttf' -o \
		-iname '*oldpersian*.ttf' -o \
		-iname '*ogham*.ttf' -o \
		-iname '*phoenician*.ttf' -o \
		-iname '*manichaean*.ttf' -o \
		-iname '*ugaritic*.ttf' -o \
		-iname '*carian*.ttf' -o \
		-iname '*inscriptional*.ttf' -o \
		-iname '*nabataean*.ttf' ')' -delete
	! use l10n_ban && find fonts -iname '*balinese*.ttf' -delete
	! use l10n_hi && find fonts -iname '*devanagari*.ttf' -delete
	! use l10n_ka && find fonts -iname '*georgian*.ttf' -delete
	! use l10n_gu && find fonts -iname '*gujarati*.ttf' -delete
	! use l10n_lo && find fonts -iname '*lao*.ttf' -delete
	! use l10n_my && find fonts -iname '*myanmar*.ttf' -delete
	! use l10n_te && find fonts -iname '*telugu*.ttf' -delete
	! use music && find fonts -iname '*music*.ttf' -delete
	! use l10n_tmh && find fonts -iname '*tifinagh*.ttf' -delete
	find . -type d -empty -delete
	default
}

src_install() {
	mkdir "${S}/install-hinted" || die
	mv fonts/Noto*"/hinted/ttf/"*.ttf "${S}/install-hinted/" || die
	FONT_S="${S}/install-hinted" font_src_install
	# Allow to drop some fonts optionally for people that want to save
	# disk space. Following ArchLinux options.
	use extra || rm -rf "${ED}"/usr/share/fonts/noto/Noto*{Condensed,SemiBold,Extra}*.ttf
	einstalldocs
}
