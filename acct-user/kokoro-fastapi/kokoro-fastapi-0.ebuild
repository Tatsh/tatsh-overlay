# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for kokoro-fastapi"
ACCT_USER_ID=601
ACCT_USER_GROUPS=( kokoro-fastapi )
ACCT_USER_HOME=/var/lib/kokoro-fastapi

acct-user_add_deps
