pkgname="extrattor"
pkgver="1.0.0"
pkgrel="1"
pkgdesc="Extractor is a simple Linux utility to extract one or more archives from the terminal"
arch=("x86_64")
source=("https://raw.githubusercontent.com/Mirko-r/extractor/main/extractor/extrattor.sh")
sha512sums=("SKIP")

package(){
    mkdir -p "${pkgdir}/usr/bin"
    mv "${srcdir}/extrattor.sh" "${pkgdir}/usr/bin/extrattor"
    chmod +x "${pkgdir}/usr/bin/extrattor"
}
