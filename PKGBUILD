# Maintainer: Xilin Wu <sophon@radxa.com>
# Upstream: https://github.com/qualcomm/fastrpc

pkgname=qcom-fastrpc
pkgver=1.0.3
pkgrel=3
pkgdesc="Qualcomm FastRPC user-space libraries and DSP RPC daemons"
arch=('aarch64' 'x86_64' 'armv7h')
url="https://github.com/qualcomm/fastrpc"
license=('BSD-3-Clause-Clear')
depends=('libyaml' 'libbsd')
makedepends=('git' 'autoconf' 'automake' 'libtool' 'pkg-config')
install=qcom-fastrpc.install
conflicts=('qcom-fastrpc-git' 'quic-fastrpc-git' 'quic-fastrpc')
source=("${pkgname}::git+https://gitea.classfun.cn:4443/mirrors/fastrpc.git#tag=v${pkgver}"
        '99-fastrpc.rules'
        'fastrpc.sysusers')
sha256sums=('SKIP' 'SKIP' 'SKIP')

prepare() {
  cd "$pkgname"
  git checkout $(git describe --tags --abbrev=0)
}

pkgver() {
  cd "$pkgname"
  git describe --tags --abbrev=0 | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'
}

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

  install -Dm644 "$srcdir/99-fastrpc.rules" "$pkgdir/usr/lib/udev/rules.d/99-fastrpc.rules"
  install -Dm644 "$srcdir/fastrpc.sysusers" "$pkgdir/usr/lib/sysusers.d/fastrpc.conf"

  # Remove libtool archives
  find "$pkgdir" -name '*.la' -delete
}
