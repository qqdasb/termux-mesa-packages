TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_DESCRIPTION="An open-source implementation of the OpenGL specification"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="docs/license.rst"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="24.5.0-fcl"
_LLVM_MAJOR_VERSION=$(. $TERMUX_SCRIPTDIR/packages/libllvm/build.sh; echo $LLVM_MAJOR_VERSION)
_LLVM_MAJOR_VERSION_NEXT=$((_LLVM_MAJOR_VERSION + 1))
TERMUX_PKG_SRCURL=git+https://gitlab.freedesktop.org/mesa/mesa.git
TERMUX_PKG_GIT_BRANCH="main"
TERMUX_PKG_DEPENDS="libandroid-shmem, libc++, libdrm, libglvnd, libllvm (<< ${_LLVM_MAJOR_VERSION_NEXT}), libxshmfence, ncurses, vulkan-loader, zlib, zstd"
TERMUX_PKG_BUILD_DEPENDS="llvm, llvm-tools, mlir"

# FIXME: Set `shared-llvm` to disabled if possible
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--cmake-prefix-path $TERMUX_PREFIX
-Dgallium-drivers=freedreno,zink,llvmpipe
-Dvulkan-drivers=freedreno
-Dfreedreno-kmds=msm,kgsl
-Dcpp_rtti=false
-Dgallium-va=disabled
-Dgbm=disabled
-Dopengl=true
-Degl=enabled
-Dgles1=enabled
-Dgles2=enabled
-Dllvm=enabled
-Dshared-llvm=enabled
-Dplatforms=android
-Dosmesa=true
-Dglvnd=enabled
-Dxmlconfig=disabled
-Dvulkan-beta=true
-Dvideo-codecs=
-Dvalgrind=disabled
-Dlibunwind=disabled
"

termux_step_post_get_source() {
	# Do not use meson wrap projects
	rm -rf subprojects
}

termux_step_pre_configure() {
	termux_setup_cmake

	CPPFLAGS+=" -D__USE_GNU"
	LDFLAGS+=" -landroid-shmem"

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
termux_step_post_configure() {
	rm -f $_WRAPPER_BIN/cmake
}
