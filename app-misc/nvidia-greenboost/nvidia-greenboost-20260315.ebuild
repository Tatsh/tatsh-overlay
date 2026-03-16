# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 systemd udev

DESCRIPTION="Hacky thing for Ollama."
HOMEPAGE="https://gitlab.com/IsolatedOctopi/nvidia_greenboost"
SHA="eaee6c29e85c89ad32dc665b9508ce3ae280ac05"
MY_PN="${PN//-/_}"
SRC_URI="https://gitlab.com/IsolatedOctopi/${MY_PN}/-/archive/${SHA}/${MY_PN}-${SHA}.tar.gz"
S="${WORKDIR}/${MY_PN}-${SHA}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-drivers/nvidia-drivers
	sci-ml/ollama[cuda]"

src_compile() {
	local modlist=( greenboost )
	local modargs=( KDIR="${KERNEL_DIR}" clean all )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	dolib.so libgreenboost_cuda.so

	cat > greenboost.conf << EOF
options greenboost physical_vram_gb=23 virtual_vram_gb=40 safety_reserve_gb=9 nvme_swap_gb=92 nvme_pool_gb=82 pcores_max_cpu=15 golden_cpu_min=0 golden_cpu_max=3 pcores_only=0
EOF
	insinto /lib/modprobe.d
	doins greenboost.conf

	cat > greenboost.sh << EOF
export GREENBOOST_SHIM="${EPREFIX}/usr/$(get_libdir)/libgreenboost_cuda.so"
EOF
	insinto /etc/profile.d
	doins greenboost.sh

	cat > greenboost-run << EOF
#!/usr/bin/env bash
LD_PRELOAD="${EPREFIX}/usr/$(get_libdir)/libgreenboost_cuda.so" "\$@"
EOF
	dobin greenboost-run

	cat > 99-greenboost.rules << 'UDEVEOF'
# GreenBoost kernel module — allow video group (includes ollama) to access /dev/greenboost
KERNEL=="greenboost", GROUP="video", MODE="0660"
UDEVEOF
	cat > 99-nvme-greenboost.rules << 'UDEVOF'
# GreenBoost NVMe tuning for T3 swap performance
ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="none"
ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/read_ahead_kb}="4096"
ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/nr_requests}="2048"
UDEVOF
	udev_dorules 99-greenboost.rules 99-nvme-greenboost.rules

	cat > 99-greenboost.conf << 'EOF'
# GreenBoost v2.3 — VM tuning for 3-tier model pool
vm.swappiness = 5
vm.dirty_ratio = 20
vm.dirty_background_ratio = 5
EOF
	insinto /lib/sysctl.d
	doins 99-greenboost.conf

	cat > 99greenboost.conf << EOF
[Service]
Environment="OLLAMA_FLASH_ATTENTION=1"
Environment="OLLAMA_KV_CACHE_TYPE=q8_0"
Environment="OLLAMA_NUM_CTX=131072"
Environment="OLLAMA_MAX_LOADED_MODELS=1"
Environment="OLLAMA_KEEP_ALIVE=-1"
Environment="GREENBOOST_VRAM_HEADROOM_MB=2048"
Environment="GREENBOOST_DEBUG=0"
Environment="LD_PRELOAD=${EPREFIX}/usr/$(get_libdir)/libgreenboost_cuda.so"
EOF
	insinto /lib/systemd/system/ollama.service.d
	doins 99greenboost.conf
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
