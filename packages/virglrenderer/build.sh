TERMUX_PKG_HOMEPAGE=https://virgil3d.github.io/
TERMUX_PKG_DESCRIPTION="A virtual 3D GPU for use inside qemu virtual machines"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.1.0-dev"
TERMUX_PKG_SRCURL=git+https://gitlab.freedesktop.org/virgl/virglrenderer.git
TERMUX_PKG_GIT_BRANCH="main"
TERMUX_PKG_DEPENDS="libdrm, libepoxy, libglvnd, libx11, mesa, vulkan-loader"
TERMUX_PKG_BUILD_DEPENDS="xorgproto"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dplatforms=egl,glx -Dvenus=true"

termux_step_pre_configure() {
	# error: using an array subscript expression within 'offsetof' is a Clang extension [-Werror,-Wgnu-offsetof-extensions]
	# list_for_each_entry_safe(struct vrend_linked_shader_program, ent, &shader->programs, sl[shader->sel->type])
	CPPFLAGS+=" -Wno-error=gnu-offsetof-extensions"
}
