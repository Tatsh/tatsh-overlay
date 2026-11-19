# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Kernel module for the embedded controller of MSI laptops"
HOMEPAGE="https://github.com/BeardOverflow/msi-ec"
SHA="b1bf9e3f9d0465934ffcfc4f02729725b0ee1973"
SRC_URI="https://github.com/BeardOverflow/msi-ec/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

MODULES_KERNEL_MAX=7.3

# The battery charge thresholds hook into the ACPI battery driver.
CONFIG_CHECK="ACPI_BATTERY"
ERROR_ACPI_BATTERY="CONFIG_ACPI_BATTERY is needed for battery_hook_register()."

src_prepare() {
	sed "s%\$(shell uname -r)%${KV_FULL}%g" -i Makefile || die
	default
}

src_compile() {
	local modlist=( "${PN}" )
	local modargs=( clean modules )
	linux-mod-r1_src_compile
}
