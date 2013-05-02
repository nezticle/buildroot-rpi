#############################################################
#
# libcec
#
#############################################################
LIBCEC_VERSION = 3ff78be261e2a30b6cb23847f4148c1344cef8df
#ab2ab9ee1ac85713acdd5c29f1c35a5992fae214
LIBCEC_SITE = git://github.com/Pulse-Eight/libcec.git
LIBCEC_INSTALL_STAGING = YES
LIBCEC_INSTALL_TARGET = YES
LIBCEC_AUTORECONF = YES
LIBCEC_CONF_OPT = CFLAGS="$(TARGET_CFLAGS) -Wno-psabi" CXXFLAGS="$(TARGET_CXXFLAGS) -Wno-psabi"

LIBCEC_DEPENDENCIES = lockdev

ifeq ($(BR2_PACKAGE_LIBCEC_RPI),y)
LIBCEC_DEPENDENCIES += rpi-userland
LIBCEC_CONF_OPT += \
	--enable-rpi \
	--with-rpi-include-path=$(STAGING_DIR)/usr/include \
	--with-rpi-lib-path=$(STAGING_DIR)/usr/lib
endif

$(eval $(autotools-package))
