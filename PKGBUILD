# Maintainer: Xilin Wu <sophon@radxa.com>
# Upstream: https://github.com/qualcomm/fastrpc

pkgname=qcom-fastrpc
pkgver=1.0.7
pkgrel=2
pkgdesc="Qualcomm FastRPC user-space libraries and DSP RPC daemons"
arch=('aarch64' 'x86_64' 'armv7h')
url="https://github.com/qualcomm/fastrpc"
license=('BSD-3-Clause-Clear')
depends=('libyaml' 'libbsd' 'acl')
makedepends=('git' 'autoconf' 'automake' 'libtool' 'pkg-config')
install=qcom-fastrpc.install
conflicts=('qcom-fastrpc-git' 'quic-fastrpc-git' 'quic-fastrpc')
source=("${pkgname}::git+https://github.com/qualcomm/fastrpc.git#tag=v${pkgver}")
sha256sums=('SKIP')

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
    --sbindir=/usr/bin \
    --with-systemdsystemunitdir=/usr/lib/systemd/system \
    --with-udevrulesdir=/usr/lib/udev/rules.d \
    --with-sysusersdir=/usr/lib/sysusers.d
  make
}

package() {
  cd "$pkgname"
  make install DESTDIR="$pkgdir"

  install -Dm644 LICENSE.txt "$pkgdir/usr/share/licenses/$pkgname/LICENSE.txt"

  # Remove libtool archives
  find "$pkgdir" -name '*.la' -delete
}
