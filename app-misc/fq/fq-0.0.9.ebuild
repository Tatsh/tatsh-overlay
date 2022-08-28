# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v1.2.0"
	"github.com/BurntSushi/toml v1.2.0/go.mod"
	"github.com/creasty/defaults v1.6.0"
	"github.com/creasty/defaults v1.6.0/go.mod"
	"github.com/golang/snappy v0.0.4"
	"github.com/golang/snappy v0.0.4/go.mod"
	"github.com/gopacket/gopacket v0.0.0-20220819214934-ee81b8c880da"
	"github.com/gopacket/gopacket v0.0.0-20220819214934-ee81b8c880da/go.mod"
	"github.com/itchyny/timefmt-go v0.1.3"
	"github.com/itchyny/timefmt-go v0.1.3/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mitchellh/copystructure v1.2.0"
	"github.com/mitchellh/copystructure v1.2.0/go.mod"
	"github.com/mitchellh/mapstructure v1.5.0"
	"github.com/mitchellh/mapstructure v1.5.0/go.mod"
	"github.com/mitchellh/reflectwalk v1.0.2"
	"github.com/mitchellh/reflectwalk v1.0.2/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/wader/gojq v0.12.1-0.20220822132002-64fe65a68424"
	"github.com/wader/gojq v0.12.1-0.20220822132002-64fe65a68424/go.mod"
	"github.com/wader/readline v0.0.0-20220704090837-31be50517a56"
	"github.com/wader/readline v0.0.0-20220704090837-31be50517a56/go.mod"
	"golang.org/x/crypto v0.0.0-20220817201139-bc19a97f63c8"
	"golang.org/x/crypto v0.0.0-20220817201139-bc19a97f63c8/go.mod"
	"golang.org/x/exp v0.0.0-20220722155223-a9213eeb770e"
	"golang.org/x/exp v0.0.0-20220722155223-a9213eeb770e/go.mod"
	"golang.org/x/net v0.0.0-20220812174116-3211cb980234"
	"golang.org/x/net v0.0.0-20220812174116-3211cb980234/go.mod"
	"golang.org/x/sys v0.0.0-20220627191245-f75cf1eec38b/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/text v0.3.7"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
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
