#############################################################
#
# rpi-userland
#
#############################################################

RPI_USERLAND_VERSION = 78f10539fa17f0601892ae3fe2f2db42f175eaa2
RPI_USERLAND_SITE = http://github.com/raspberrypi/userland/tarball/master
RPI_USERLAND_LICENSE = BSD-3c
RPI_USERLAND_LICENSE_FILE = LICENCE
RPI_USERLAND_INSTALL_STAGING = YES
RPI_USERLAND_CONF_OPT = -DVMCS_INSTALL_PREFIX=/usr

define RPI_USERLAND_POST_TARGET_CLEANUP
	rm -f $(TARGET_DIR)/etc/init.d/vcfiled
	rm -Rf $(TARGET_DIR)/usr/src
endef

RPI_USERLAND_POST_INSTALL_TARGET_HOOKS += RPI_USERLAND_POST_TARGET_CLEANUP

$(eval $(cmake-package))
