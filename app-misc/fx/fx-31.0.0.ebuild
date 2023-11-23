# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

EGO_SUM=(
	"github.com/antonmedv/clipboard v1.0.1"
	"github.com/antonmedv/clipboard v1.0.1/go.mod"
	"github.com/atotto/clipboard v0.1.4"
	"github.com/atotto/clipboard v0.1.4/go.mod"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1/go.mod"
	"github.com/aymanbagabas/go-udiff v0.1.3"
	"github.com/aymanbagabas/go-udiff v0.1.3/go.mod"
	"github.com/charmbracelet/bubbles v0.16.1"
	"github.com/charmbracelet/bubbles v0.16.1/go.mod"
	"github.com/charmbracelet/bubbletea v0.24.2"
	"github.com/charmbracelet/bubbletea v0.24.2/go.mod"
	"github.com/charmbracelet/lipgloss v0.9.1"
	"github.com/charmbracelet/lipgloss v0.9.1/go.mod"
	"github.com/charmbracelet/x/exp/teatest v0.0.0-20231025135604-4a717d4fb812"
	"github.com/charmbracelet/x/exp/teatest v0.0.0-20231025135604-4a717d4fb812/go.mod"
	"github.com/containerd/console v1.0.4-0.20230313162750-1ae8d489ac81"
	"github.com/containerd/console v1.0.4-0.20230313162750-1ae8d489ac81/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mattn/go-localereader v0.0.1"
	"github.com/mattn/go-localereader v0.0.1/go.mod"
	"github.com/mattn/go-runewidth v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.15"
	"github.com/mattn/go-runewidth v0.0.15/go.mod"
	"github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6"
	"github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6/go.mod"
	"github.com/muesli/cancelreader v0.2.2"
	"github.com/muesli/cancelreader v0.2.2/go.mod"
	"github.com/muesli/reflow v0.3.0"
	"github.com/muesli/reflow v0.3.0/go.mod"
	"github.com/muesli/termenv v0.15.2"
	"github.com/muesli/termenv v0.15.2/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.1.0/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.4"
	"github.com/rivo/uniseg v0.4.4/go.mod"
	"github.com/sahilm/fuzzy v0.1.0"
	"github.com/sahilm/fuzzy v0.1.0/go.mod"
	"github.com/stretchr/testify v1.8.4"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"golang.org/x/sync v0.5.0"
	"golang.org/x/sync v0.5.0/go.mod"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.14.0"
	"golang.org/x/sys v0.14.0/go.mod"
	"golang.org/x/term v0.13.0"
	"golang.org/x/term v0.13.0/go.mod"
	"golang.org/x/text v0.14.0"
	"golang.org/x/text v0.14.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)
go-module_set_globals
MY_PV=$(ver_rs 3 -)
DESCRIPTION="Terminal JSON viewer."
HOMEPAGE="https://fx.wtf"
SRC_URI="https://github.com/antonmedv/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 BSD-2 BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	go build . || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
