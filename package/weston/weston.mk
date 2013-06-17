#############################################################
#
# weston
#
#############################################################

WESTON_VERSION = 1.1.1
WESTON_SITE = http://wayland.freedesktop.org/releases/
WESTON_SOURCE = weston-$(WESTON_VERSION).tar.xz
WESTON_AUTORECONF = YES
WESTON_LICENSE = MIT
WESTON_LICENSE_FILES = COPYING

WESTON_DEPENDENCIES = wayland libxkbcommon pixman libpng \
	jpeg mtdev udev cairo
WESTON_CONF_OPT = \
	--disable-setuid-install \
	--disable-xwayland \
	--disable-xwayland-test \
	--disable-x11-compositor \
	--disable-drm-compositor \
	--disable-wayland-compositor \
	--disable-headless-compositor \
	--disable-weston-launch \
	--disable-colord \
	--disable-resize-optimization \
	--disable-libunwind

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
WESTON_CONF_OPT += \
	--with-cairo-glesv2 \
	--disable-simple-egl-clients \
	--enable-rpi-compositor \
	WESTON_NATIVE_BACKEND="rpi-backend.so"
WESTON_DEPENDENCIES += rpi-userland
else
WESTON_CONF_OPT += \
	--disable-egl \
	--disable-rpi-compositor
endif

ifeq ($(BR2_PACKAGE_WESTON_FBDEV),y)
WESTON_CONF_OPT += --enable-fbdev-compositor
else
WESTON_CONF_OPT += --disable-fbdev-compositor
endif

$(eval $(autotools-package))

