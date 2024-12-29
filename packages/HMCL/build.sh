TERMUX_PKG_HOMEPAGE=https://hmcl.huangyuhui.net/
TERMUX_PKG_DESCRIPTION="A Minecraft Launcher which is multi-functional, cross-platform and popular"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@qqdasb"
TERMUX_PKG_VERSION=3.6.11-dev
TERMUX_PKG_SRCURL=git+https://github.com/HMCL-dev/HMCL.git
TERMUX_PKG_GIT_BRANCH="main"
TERMUX_PKG_DEPENDS="openjdk-8 | openjdk-17 | openjdk-21"
TERMUX_PKG_BUILD_DEPENDS="gradle"

termux_step_make() {
	gradle clean build
}
