# Maintainer: Xilin Wu <sophon@radxa.com>
# Upstream: https://github.com/qualcomm/fastrpc

pkgname=qcom-fastrpc
pkgver=1.0.7
pkgrel=3
pkgdesc="Qualcomm FastRPC user-space libraries and DSP RPC daemons"
arch=('aarch64' 'x86_64' 'armv7h')
url="https://github.com/qualcomm/fastrpc"
license=('BSD-3-Clause-Clear')
depends=('libyaml' 'libbsd' 'acl')
makedepends=('git' 'autoconf' 'automake' 'libtool' 'pkg-config')
install=qcom-fastrpc.install
conflicts=('qcom-fastrpc-git' 'quic-fastrpc-git' 'quic-fastrpc')
source=(
  "${pkgname}::git+https://github.com/qualcomm/fastrpc.git#tag=v${pkgver}"
  'setup-dsp.sh'
  'qcom-fastrpc-setup-dsp.service'
  'qcom-fastrpc-setup-dsp.conf'
)
sha256sums=('SKIP'
            '6107d7d654fd835029fb82262f81c9a669f25b143d1d71d16aee8eab134d0030'
            '6e3f1aa959842d8754ffbcf466658161bd001b75d23bfe7608934bb1bdaa3099'
            'd57befd7f2fbf3b2ee2ca973b20a97551a3fb1ea6afdbfb67531698deff07619')

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
  install -Dm755 "$srcdir/setup-dsp.sh" "$pkgdir/usr/libexec/fastrpc/setup-dsp.sh"
  install -Dm644 "$srcdir/qcom-fastrpc-setup-dsp.service" \
    "$pkgdir/usr/lib/systemd/system/qcom-fastrpc-setup-dsp.service"

  for daemon in adsprpcd adsprpcd_audiopd cdsp1rpcd cdsprpcd gdsp0rpcd gdsp1rpcd sdsprpcd; do
    install -Dm644 "$srcdir/qcom-fastrpc-setup-dsp.conf" \
      "$pkgdir/usr/lib/systemd/system/$daemon.service.d/qcom-fastrpc-setup-dsp.conf"
  done

  # Remove libtool archives
  find "$pkgdir" -name '*.la' -delete
}
