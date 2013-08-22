#############################################################
#
# libcec
#
#############################################################
LIBCEC_VERSION = 3befc9811e59359c014c33c1276f869d5b59ac09
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
