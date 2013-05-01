#############################################################
#
# rpi-userland
#
#############################################################

RPI_USERLAND_VERSION = a158f9ab70eb217b5ee72ebd83c1536418df7c7c
RPI_USERLAND_SITE = http://github.com/raspberrypi/userland/tarball/master
RPI_USERLAND_LICENSE = BSD-3c
RPI_USERLAND_LICENSE_FILE = LICENCE
RPI_USERLAND_INSTALL_STAGING = YES
RPI_USERLAND_CONF_OPT = -DVMCS_INSTALL_PREFIX=/usr

define RPI_USERLAND_POST_TARGET_CLEANUP
    rm -Rf $(TARGET_DIR)/usr/src
endef

RPI_USERLAND_POST_INSTALL_TARGET_HOOKS += RPI_USERLAND_POST_TARGET_CLEANUP

$(eval $(cmake-package))
