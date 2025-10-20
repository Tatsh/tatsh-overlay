# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for tabbyapi"
ACCT_USER_ID="-1"
ACCT_USER_GROUPS=( tabbyapi video )
ACCT_USER_HOME="/var/lib/tabbyapi"
