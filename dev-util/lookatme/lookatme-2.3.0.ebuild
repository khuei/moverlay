# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DISTUTILS_USE_SETUPTOOLS=rdepend

DESCRIPTION="An interactive, terminal-based markdown presenter"
HOMEPAGE="https://github.com/d0c-s4vage/lookatme"
SRC_URI="https://github.com/d0c-s4vage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RESTRICT="mirror"

RDEPEND="
	dev-python/marshmallow
	dev-python/click
	dev-python/pyyaml
	dev-python/mistune
	dev-python/urwid
	dev-python/pygments
"

PATCHES=(
	"${FILESDIR}"/exclude-test-from-install.diff
)

distutils_enable_tests pytest

python_prepare_all() {
	sed -i "s/{{VERSION}}/${PV}/" lookatme/__init__.py || die
	distutils-r1_python_prepare_all
}
