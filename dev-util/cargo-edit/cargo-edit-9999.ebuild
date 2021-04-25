# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

if [[ "${PV}" == *'9999'* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/killercup/cargo-edit"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/killercup/cargo-edit/archive/v${PV}.tar.gz -> ${P}.tar.gz $(cargo_crate_uris ${CRATES})"
fi

DESCRIPTION="A utility for managing cargo dependencies from the command line"
HOMEPAGE="https://github.com/killercup/cargo-edit"
LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="mirror"

DEPEND="
	|| (
		>=dev-lang/rust-1.51.0
		>=dev-lang/rust-bin-1.51.0
	)
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install
}
