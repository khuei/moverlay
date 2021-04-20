# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

if [[ ${PV} == *'9999'* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/achannarasappa/ticker"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/achannarasappa/ticker/archive/v${PV}.tar.gz -> ${P}.tar.gz ${EGO_SUM_SRC_URI}"
fi

DESCRIPTION="General purpose Language Server"
HOMEPAGE="https://github.com/golang/tools/tree/master/gopls"

LICENSE="BSD"
KEYWORDS=""
SLOT="0"
IUSE=""
RESTRICT="mirror"

src_unpack() {
	if [[ ${PV} == *'9999'* ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		go-module_src_unpack
	fi
}

src_compile() {
	go build || die
}

src_install() {
	dobin ticker
}
