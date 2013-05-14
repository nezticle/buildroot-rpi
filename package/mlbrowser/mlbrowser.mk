# Metrological's example of a webkit (accelerated) browser

MLBROWSER_VERSION=1.1
MLBROWSER_SITE_METHOD=local
MLBROWSER_SITE=$(TOPDIR)/package/mlbrowser/src

ifeq ($(BR2_PACKAGE_QT5WEBKIT),y)
MLBROWSER_DEPENDENCIES = qt5webkit gstreamer
endif

ifeq ($(BR2_PACKAGE_QT_WEBKIT),y)
MLBROWSER_DEPENDENCIES = qt gstreamer
endif

define MLBROWSER_CONFIGURE_CMDS
	# 'clean' if Makefile exist
	[ -f "$(@D)/Makefile" ] && $(MAKE) -C $(@D) distclean  || echo "Warning: nothing to clean, no Makefile found"

        # run qmake
	(cd $(@D) && $(HOST_DIR)/usr/bin/qmake )
endef
	
define MLBROWSER_BUILD_CMDS
        $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef
	
define MLBROWSER_INSTALL_STAGING_CMDS
	# 'install' is defined in *.pro
        $(MAKE) -C $(@D) install
endef
	
define MLBROWSER_INSTALL_TARGET_CMDS
	# copy binary
        cp -dpf $(@D)/mlbrowser $(TARGET_DIR)/usr/bin
endef
	
define MLBROWSER_UNINSTALL_TARGET_CMDS
	# 'clean' binary
        rm $(TARGET_DIR)/usr/bin/mlbrowser
endef
	
$(eval $(generic-package)) 
