#############################################################
#
# qt5wktst
#
#############################################################

QT5WKTST_VERSION = 0.0.1
QT5WKTST_SITE = $(TOPDIR)/package/qt5/qt5wktst/src
QT5WKTST_SITE_METHOD = local
QT5WKTST_SOURCE = qt5wktst-0.1.tar.gz
QT5WKTST_DEPENDENCIES = qt5webkit

define QT5WKTST_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/qmake)
endef

define QT5WKTST_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WKTST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/wktst $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
