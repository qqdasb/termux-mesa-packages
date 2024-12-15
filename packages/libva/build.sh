TERMUX_PKG_HOMEPAGE=https://01.org/linuxmedia/vaapi
TERMUX_PKG_DESCRIPTION="Video Acceleration (VA) API for Linux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@qqdasb"
TERMUX_PKG_VERSION=2.23.0.1-dev
TERMUX_PKG_SRCURL=git+https://github.com/intel/libva.git
TERMUX_PKG_GIT_BRANCH="master"
TERMUX_PKG_DEPENDS="libdrm, libglvnd, libx11, libxext, libxfixes, libwayland"

termux_step_configure() {
	CFLAGS+=" -DENABLE_VA_MESSAGING"
	termux_step_configure_meson
}
