#############################################################
#
# qt5xmlpatterns
#
#############################################################

QT5XMLPATTERNS_VERSION = ce0f629b741f268d0546a775d9d8f4eec99d21d0
QT5XMLPATTERNS_SITE = git://gitorious.org/qt/qtxmlpatterns.git
QT5XMLPATTERNS_SITE_METHOD = git

QT5XMLPATTERNS_DEPENDENCIES = qt5base

QT5XMLPATTERNS_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_QT5BASE_LICENSE_APPROVED),y)
QT5XMLPATTERNS_CONFIGURE_OPTS += -opensource -confirm-license
QT5XMLPATTERNS_LICENSE = LGPLv2.1 or GPLv3.0
# Here we would like to get license files from qt5base, but qt5base
# may not be extracted at the time we get the legal-info for
# qt5script.
else
QT5XMLPATTERNS_LICENSE = Commercial license
QT5XMLPATTERNS_REDISTRIBUTE = NO
endif

define QT5XMLPATTERNS_CONFIGURE_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/qmake)
endef

define QT5XMLPATTERNS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5XMLPATTERNS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

ifeq ($(BR2_PREFER_STATIC_LIB),)
define QT5XMLPATTERNS_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5XmlPatterns*.so.* $(TARGET_DIR)/usr/lib
endef
endif

$(eval $(generic-package))
