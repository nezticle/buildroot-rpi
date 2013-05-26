#############################################################
#
# wayland
#
#############################################################

WAYLAND_VERSION = 1.1.0
WAYLAND_SITE = http://wayland.freedesktop.org/releases/
WAYLAND_SOURCE = wayland-$(WAYLAND_VERSION).tar.xz
#WAYLAND_VERSION = d68c7d8aed92158ae68fd9cabb8bc2a50fd5066b
#WAYLAND_SITE = http://cgit.freedesktop.org/wayland/wayland/snapshot/
#WAYLAND_SOURCE = wayland-$(WAYLAND_VERSION).tar.gz
#WAYLAND_AUTORECONF = YES
WAYLAND_LICENSE = MIT
WAYLAND_LICENSE_FILES = COPYING

WAYLAND_INSTALL_STAGING = YES
WAYLAND_DEPENDENCIES = libffi host-pkgconf expat host-expat

# wayland needs a wayland-scanner program to generate some of its
# source code. By default, it builds it with CC, so it doesn't work with
# cross-compilation. Therefore, we build it manually, and tell wayland
# that the tool is already available.
WAYLAND_CONF_OPT = --disable-scanner

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
WAYLAND_DEPENDENCIES += rpi-userland
endif

define WAYLAND_BUILD_SCANNER
	(cd $(@D)/src/; \
		$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) \
			-o wayland-scanner scanner.c wayland-util.c -lexpat)
	cp -f $(@D)/src/wayland-scanner $(HOST_DIR)/usr/bin/
endef

WAYLAND_POST_CONFIGURE_HOOKS += WAYLAND_BUILD_SCANNER

$(eval $(autotools-package))
