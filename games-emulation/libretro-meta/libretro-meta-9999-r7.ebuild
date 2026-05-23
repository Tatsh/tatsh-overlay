# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for various libretro implementations"
HOMEPAGE="https://www.libretro.com/"
LICENSE="metapackage"
SLOT="0"

# The below list is what used to be provided by the menelkir overlay
# Please submit a pull request to re-enable any that are currently left out

#IUSE="2048 3dengine 81 atari800 bk blastem bluemsx bnes boom3 bsnes cannonball cap32 chailove citra \
#	craft crocods desmume dinothawr dosbox-svn swanstation ecwolf fbalpha fbalpha2012 fbneo \
#	fceu-next ffmpeg freechaf freeintv frodo gambatte gearboy gearsystem \
#	genesis-plus-gx_wide gme gong gpsp gw handy hatari lowresnx lutro mame2000 mame2003 \
#	mame2010 mame2015 mess2015 mednafen-bsnes mednafen-gba mednafen-lynx mednafen-ngp mednafen-pce \
#	mednafen-pce-fast mednafen-pcfx mednafen-saturn mednafen-supafaust \
#	mednafen-supergrafx mednafen-vb mednafen-wswan melonds meowpc98 mesen mesens meteor mgba mrboom mu mupen64 \
#	np2kai neocd nestopia nxengine o2em oberon opera openlara parallel_n64 picodrive pocketcdg \
#	pokemini potator ppsspp prosystem px68k quicknes quasi88 race retro8 reminiscence \
#	sameboy scummvm smsplus snes9x2002 snes9x2005 snes9x2010 squirreljme stella2014 tgbdual tic80 theodore \
#	thepowdertoy uzem vba-next vbam vecx vemulator vice-x128 vice-xcbm2 vice-xcbm5x0 \
#	vice-xpet vice-xplus4 vice-xscpu64 vice-xvic virtualjaguar vitaquake2 vitaquake3 x1 xrick yabause"

KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="
	bsnes-mercury dolphin dosbox fceumm flycast fmsx fuse genesis-plus-gx mame2003-plus mednafen-psx mednafen-psx-hw
	pcsx-rearmed ppsspp prboom puae puae2021 snes9x swanstation tyrquake vice-x64 vice-x64sc"

RDEPEND="
	bsnes-mercury? ( games-emulation/libretro-bsnes-mercury-performance )
	!x86? ( dolphin? ( games-emulation/libretro-dolphin ) )
	dosbox? ( games-emulation/libretro-dosbox )
	fceumm? ( games-emulation/libretro-fceumm )
	flycast? ( games-emulation/libretro-flycast )
	fmsx? ( games-emulation/libretro-fmsx )
	fuse? ( games-emulation/libretro-fuse )
	genesis-plus-gx? ( games-emulation/libretro-genesis-plus-gx )
	mame2003-plus? ( games-emulation/libretro-mame2003-plus )
	mednafen-psx? ( games-emulation/libretro-mednafen-psx )
	mednafen-psx-hw? ( games-emulation/libretro-mednafen-psx-hw )
	pcsx-rearmed? ( games-emulation/libretro-pcsx-rearmed )
	ppsspp? ( games-emulation/libretro-ppsspp )
	prboom? ( games-emulation/libretro-prboom )
	puae? ( games-emulation/libretro-puae )
	puae2021? ( games-emulation/libretro-puae2021 )
	snes9x? ( games-emulation/libretro-snes9x )
	!x86? ( swanstation? ( games-emulation/libretro-swanstation ) )
	tyrquake? ( games-emulation/libretro-tyrquake )
	vice-x64? ( games-emulation/libretro-vice-x64 )
	vice-x64sc? ( games-emulation/libretro-vice-x64sc )"
