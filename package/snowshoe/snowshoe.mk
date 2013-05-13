#############################################################
#
# snowshoe
#
#############################################################

SNOWSHOE_VERSION=35afbe295043bd3e27357b8e987ec19b54bfd8c8
SNOWSHOE_SITE_METHOD=git
SNOWSHOE_SITE=https://git.gitorious.org/qt-apps/snowshoe.git
SNOWSHOE_DEPENDENCIES = qt5webkit
SNOWSHOE_LICENSE = LGPLv2.1
SNOWSHOE_LICENSE_FILES = LICENSE

define SNOWSHOE_CONFIGURE_CMDS
	# 'clean' if Makefile exist
	[ -f "$(@D)/Makefile" ] && $(MAKE) -C $(@D) distclean  || echo "Warning: nothing to clean, no Makefile found"
	# run qmake
	(cd $(@D) && $(HOST_DIR)/usr/bin/qmake)
endef

define SNOWSHOE_BUILD_CMDS
        $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define SNOWSHOE_INSTALL_TARGET_CMDS
	# copy binary
	$(INSTALL) -D -m 0755 $(@D)/snowshoe $(TARGET_DIR)/usr/bin
endef

define SNOWSHOE_UNINSTALL_TARGET_CMDS
	# 'clean' binary
	rm $(TARGET_DIR)/usr/bin/snowshoe
endef

$(eval $(generic-package))
