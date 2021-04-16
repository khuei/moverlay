# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DISTUTILS_USE_SETUPTOOLS=rdepend

MY_PV="9365a5845898a8ed29b72057815104141a74b033"
MY_P="base16-builder-python-${MY_PV}"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="Python base16 colorscheme builder"
HOMEPAGE="https://github.com/InspectorMustache/base16-builder-python"
SRC_URI="https://github.com/InspectorMustache/base16-builder-python/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RESTRICT="mirror"

RDEPEND="
	dev-python/pystache
	dev-python/aiofiles
	dev-python/pyyaml
"

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all
}
