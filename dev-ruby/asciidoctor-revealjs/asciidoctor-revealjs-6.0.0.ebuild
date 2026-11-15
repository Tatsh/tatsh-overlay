# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.adoc"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="A reveal.js converter for Asciidoctor"
HOMEPAGE="https://github.com/asciidoctor/asciidoctor-reveal.js"
SRC_URI="https://github.com/asciidoctor/asciidoctor-reveal.js/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RUBY_S="asciidoctor-reveal.js-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend ">=dev-ruby/asciidoctor-2.0.0 <dev-ruby/asciidoctor-3"
ruby_add_bdepend "test? ( dev-ruby/minitest dev-ruby/slim dev-ruby/tilt )"

all_ruby_prepare() {
	rm -f Gemfile || die

	sed -e 's/git ls-files -z/find * -print0/' \
		-i "${RUBY_FAKEGEM_GEMSPEC}" || die

	# Remove development dependencies from gemspec
	sed -e '/add_development_dependency/d' \
		-i "${RUBY_FAKEGEM_GEMSPEC}" || die
}

each_ruby_test() {
	# test/converter-testkit needs asciidoctor-doctest, which is not packaged; the
	# minitest suite does not.
	${RUBY} -Ilib:test -e 'Dir["test/asciidoctor_revealjs/*_test.rb"].each { |f| require File.expand_path(f) }' \
		|| die "Tests failed with ${RUBY}"
}
