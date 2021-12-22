# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

EGO_SUM=(
	"github.com/chzyer/logex v1.1.10"
	"github.com/chzyer/logex v1.1.10/go.mod"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/google/go-cmp v0.5.4/go.mod"
	"github.com/google/gopacket v1.1.19"
	"github.com/google/gopacket v1.1.19/go.mod"
	"github.com/itchyny/timefmt-go v0.1.3"
	"github.com/itchyny/timefmt-go v0.1.3/go.mod"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mitchellh/mapstructure v1.4.3"
	"github.com/mitchellh/mapstructure v1.4.3/go.mod"
	"github.com/nbutton23/zxcvbn-go v0.0.0-20210217022336-fa2cb2858354/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/testify v1.1.4/go.mod"
	"github.com/wader/gojq v0.12.1-0.20211211101122-3894ded312be"
	"github.com/wader/gojq v0.12.1-0.20211211101122-3894ded312be/go.mod"
	"github.com/wader/readline v0.0.0-20210920124728-5a81f7707bac"
	"github.com/wader/readline v0.0.0-20210920124728-5a81f7707bac/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/lint v0.0.0-20200302205851-738671d3881b/go.mod"
	"golang.org/x/mod v0.1.1-0.20191105210325-c90efee705ee/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20211124211545-fe61309f8881"
	"golang.org/x/sys v0.0.0-20211124211545-fe61309f8881/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.7"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20200130002326-2f3ba24bd6e7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b/go.mod"
)

go-module_set_globals

DESCRIPTION="jq for binary formats"
HOMEPAGE="https://github.com/wader/fq"
SRC_URI="https://github.com/wader/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dobin "${PN}"
	einstalldocs
}
