QT5WAYLAND_VERSION = d48747b266298904ddc199bf1d9e422cd66e261a
QT5WAYLAND_SITE = git://gitorious.org/qt/qtwayland.git
QT5WAYLAND_SITE_METHOD = git

QT5WAYLAND_DEPENDENCIES = qt5base qt5xmlpatterns qt5jsbackend qt5declarative wayland

QT5WAYLAND_INSTALL_STAGING = YES

define QT5WAYLAND_CONFIGURE_CMDS
	-[ -f $(@D)/Makefile ] && $(MAKE) -C $(@D) distclean
	(cd $(@D) && $(HOST_DIR)/usr/bin/qmake) 
#	(cd $(@D) && $(HOST_DIR)/usr/bin/qmake QT_WAYLAND_GL_CONFIG=brcm_egl) 
##	(cd $(@D) && $(HOST_DIR)/usr/bin/qmake CONFIG+=wayland-compositor)
endef

define QT5WAYLAND_BUILD_CMDS
 	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WAYLAND_INSTALL_STAGING_CMDS
#	$(MAKE) -C $(@D) install
endef

define QT5WAYLAND_INSTALL_TARGET_CMDS
#	cp -dpf $(STAGING_DIR)/usr/lib/libQtCompositor*.so* $(TARGET_DIR)/usr/lib
#	cp -dpf $(STAGING_DIR)/usr/plugins/platforms/libqwayland.so $(TARGET_DIR)/usr/plugins/platforms/
endef

define QT5WAYLAND_UNINSTALL_TARGET_CMDS
#	-rm $(TARGET_DIR)/usr/lib/libQtCompositor*.so*
#	-rm $(TARGET_DIR)/usr/plugins/platforms/libqwalynad.so
endef

$(eval $(generic-package))

