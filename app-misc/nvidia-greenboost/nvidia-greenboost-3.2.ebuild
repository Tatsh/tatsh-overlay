# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 systemd udev

DESCRIPTION="Hacky thing for Ollama."
# Upstream renamed the project from nvidia_greenboost to greenboost.
HOMEPAGE="https://gitlab.com/IsolatedOctopi/greenboost"
MY_PN="greenboost"
SRC_URI="https://gitlab.com/IsolatedOctopi/${MY_PN}/-/archive/v${PV}/${MY_PN}-v${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-v${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-drivers/nvidia-drivers
	sci-ml/ollama[cuda]"

src_compile() {
	local modlist=( greenboost )
	# No "clean" target here: it has no ordering dependency on "all", so a
	# parallel make can delete greenboost_cuda_v12.o between the shim's compile
	# and link steps. The tree is freshly unpacked anyway.
	local modargs=( KDIR="${KERNEL_DIR}" all )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	# Everything "make all" produces. The audit shim is also installed under
	# the 32-bit path the loader looks in for i386 CUDA clients.
	dolib.so libgreenboost_cuda.so libgreenboost_audit.so \
		libgreenboost_netd_capture.so
	if [[ -f libgreenboost_vmm_override.so ]]; then
		dolib.so libgreenboost_vmm_override.so
	fi
	if [[ -f libgreenboost_audit32.so ]]; then
		into /usr
		insinto /usr/lib/i386-linux-gnu
		newins libgreenboost_audit32.so libgreenboost_audit.so
	fi
	dobin greenboost-netd
	if [[ -f greenboost-ebpf-trace ]]; then
		dobin greenboost-ebpf-trace
	fi
	systemd_dounit greenboost-netd.service greenboost-boot-guard.service

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
