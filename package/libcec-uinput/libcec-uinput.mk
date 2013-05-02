#############################################################
#
# libcec-uinput
#
#############################################################
LIBCEC_UINPUT_VERSION = cb086865869402fdabe3b9142ea7e6ea3c699c1b
LIBCEC_UINPUT_SITE = git://github.com/bramp/libcec-daemon.git
LIBCEC_UINPUT_INSTALL_STAGING = YES
LIBCEC_UINPUT_INSTALL_TARGET = YES

LIBCEC_UINPUT_DEPENDENCIES = libcec boost log4cplus

define LIBCEC_UINPUT_CONFIGURE_CMDS
endef

define LIBCEC_UINPUT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		LDFLAGS="-lcec -ldl -lboost_program_options -llog4cplus -lbcm_host -lvcos -lvchiq_arm"
endef

define LIBCEC_UINPUT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/libcec-daemon $(TARGET_DIR)/usr/bin/cecd
	$(INSTALL) -D -m 755 package/libcec-uinput/S70cecd $(TARGET_DIR)/etc/init.d/S70cecd
endef

$(eval $(generic-package))
