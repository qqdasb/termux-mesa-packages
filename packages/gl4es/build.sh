TERMUX_PKG_HOMEPAGE=https://ptitseb.github.io/gl4es/
TERMUX_PKG_DESCRIPTION="GL4ES is a OpenGL 2.1/1.5 to GL ES 2.0/1.1 translation library, with support for Pandora, ODroid, OrangePI, CHIP, Raspberry PI, Android, Emscripten and AmigaOS4."
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.1.4"
TERMUX_PKG_SRCURL=git+https://github.com/ptitSeb/gl4es
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="libx11"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DTERMUX=ON
-DCMAKE_SYSTEM_NAME=Linux
"

termux_step_pre_configure() {
	# benchmark result as follows:
	# -O2 -flto > -O3 -flto > -O2 > -Os > -Os -flto > -O3 > -Oz > -Oz -flto
	export CFLAGS="${CFLAGS/-Oz/-O2} -flto"
}

termux_step_post_make_install() {
	rm -fr "${TERMUX_PREFIX}/lib/gl4es/libGL.so"
	ln -fs "libGL.so.1" "${TERMUX_PREFIX}/lib/gl4es/libGL.so"
}
