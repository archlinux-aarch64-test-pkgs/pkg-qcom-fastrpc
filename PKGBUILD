# Maintainer: Xilin Wu <sophon@radxa.com>
# Upstream: https://github.com/qualcomm/fastrpc

pkgname=qcom-fastrpc
pkgver=1.0.3
pkgrel=1
pkgdesc="Qualcomm FastRPC user-space libraries and DSP RPC daemons"
arch=('aarch64')
url="https://github.com/qualcomm/fastrpc"
license=('BSD-3-Clause-Clear')
depends=('libyaml' 'libbsd')
makedepends=('git' 'autoconf' 'automake' 'libtool' 'pkg-config')
options=('!strip')
source=("${pkgname}::git+https://gitea.classfun.cn:4443/mirrors/fastrpc.git#tag=v${pkgver}")
sha256sums=('SKIP')

build() {
  cd "$pkgname"
  autoreconf -is
  ./configure \
    --prefix=/usr \
    --with-systemdsystemunitdir=/usr/lib/systemd/system
  make
}

package() {
  cd "$pkgname"
  make install DESTDIR="$pkgdir"

  install -Dm644 LICENSE.txt "$pkgdir/usr/share/licenses/$pkgname/LICENSE.txt"

  # Remove libtool archives
  find "$pkgdir" -name '*.la' -delete
}
