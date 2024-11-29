TERMUX_PKG_HOMEPAGE=https://wayland.freedesktop.org/
TERMUX_PKG_DESCRIPTION="Wayland protocols library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.38"
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/${TERMUX_PKG_VERSION}/downloads/wayland-protocols-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=ff17292c05159d2b20ce6cacfe42d7e31a28198fa1429a769b03af7c38581dbe
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
"

termux_step_pre_configure() {
	_WRAPPER_BIN=$TERMUX_PKG_BUILDDIR/_wrapper/bin
	mkdir -p $_WRAPPER_BIN
	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		sed 's|@CMAKE@|'"$(command -v cmake)"'|g' \
			$TERMUX_PKG_BUILDER_DIR/cmake-wrapper.in \
			> $_WRAPPER_BIN/cmake
		chmod 0700 $_WRAPPER_BIN/cmake
		termux_setup_wayland_cross_pkg_config_wrapper
		export LLVM_CONFIG="$TERMUX_PREFIX/bin/llvm-config"
	fi
	export PATH="$_WRAPPER_BIN:$PATH"
}
