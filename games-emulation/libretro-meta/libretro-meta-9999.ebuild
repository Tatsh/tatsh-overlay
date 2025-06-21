# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for various libretro implementations"
HOMEPAGE="http://www.libretro.com/"
LICENSE="metapackage"
SLOT="0"

# The below list is what used to be provided by the menelkir overlay
# Please submit a pull request to re-enable any that are currently left out

#IUSE="2048 3dengine 81 atari800 bk blastem bluemsx bnes boom3 bsnes bsnes-mercury cannonball cap32 chailove citra \
#	craft crocods desmume dinothawr dolphin dosbox dosbox-svn swanstation ecwolf fbalpha fbalpha2012 fbneo fceumm \
#	fceu-next ffmpeg flycast fmsx freechaf freeintv frodo fuse gambatte gearboy gearsystem genesis_plus_gx \
#	genesis_plus_gx_wide gme gong gpsp gw handy hatari lowresnx lutro mame2000 mame2003 mame2003_plus-libretro \
#	mame2010 mame2015 mess2015 mednafen-bsnes mednafen-gba mednafen-lynx mednafen-ngp mednafen-pce \
#	mednafen-pce-fast mednafen-pcfx mednafen-psx mednafen-psx-hw mednafen-saturn mednafen-supafaust \
#	mednafen-supergrafx mednafen-vb mednafen-wswan melonds meowpc98 mesen mesens meteor mgba mrboom mu mupen64 \
#	np2kai neocd nestopia nxengine o2em oberon opera openlara parallel_n64 pcsx-rearmed picodrive pocketcdg \
#	pokemini potator ppsspp prboom prosystem puae puae2021 px68k quicknes quasi88 race retro8 reminiscence \
#	sameboy scummvm smsplus snes9x snes9x2002 snes9x2005 snes9x2010 squirreljme stella2014 tgbdual tic80 theodore \
#	thepowdertoy tyrquake uzem vba-next vbam vecx vemulator vice-x128 vice-x64 vice-x64sc vice-xcbm2 vice-xcbm5x0 \
#	vice-xpet vice-xplus4 vice-xscpu64 vice-xvic virtualjaguar vitaquake2 vitaquake3 x1 xrick yabause"

IUSE="dolphin dosbox flycast fmsx fuse mednafen-psx mednafen-psx-hw mupen64 pcsx-rearmed ppsspp puae puae2021 snes9x swanstation tyrquake vice-x64 vice-x64sc"

KEYWORDS="~amd64 ~x86 ~arm64"

RDEPEND="
	dolphin? ( games-emulation/dolphin-libretro )
	dosbox? ( games-emulation/libretro-dosbox )
	flycast? ( games-emulation/flycast-libretro )
	fmsx? ( games-emulation/fmsx-libretro )
	fuse? ( games-emulation/fuse-libretro )
	mednafen-psx? ( games-emulation/mednafen-psx-libretro )
	mednafen-psx-hw? ( games-emulation/mednafen-psx-hw-libretro )
	mupen64? ( games-emulation/mupen64next-libretro )
	pcsx-rearmed? ( games-emulation/pcsx-rearmed-libretro )
	ppsspp? ( games-emulation/ppsspp-libretro )
	puae? ( games-emulation/puae-libretro )
	puae2021? ( games-emulation/puae2021-libretro )
	snes9x? ( games-emulation/libretro-snes9x )
	swanstation? ( games-emulation/swanstation-libretro ) 
	tyrquake? ( games-emulation/tyrquake-libretro )
	vice-x64? ( games-emulation/vice-x64-libretro )
	vice-x64sc? ( games-emulation/vice-x64sc-libretro )"
DEPEND=""
