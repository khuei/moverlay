# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tarkah/tickrs"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/tarkah/tickrs/archive/v${PV}.tar.gz -> ${P}.tar.gz $(cargo_crate_uris ${CRATES})"
fi

DESCRIPTION="Realtime ticker data in your terminal"
HOMEPAGE="https://github.com/tarkah/tickrs"

LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="mirror"

DEPEND="
	|| (
		>=dev-lang/rust-1.51.0[rls]
		>=dev-lang/rust-bin-1.51.0[rls]
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
