QT5WAYLAND_VERSION = 11b0a7db584d21eb7eb94849de79ad033249ae3c
QT5WAYLAND_SITE = git://gitorious.org/qt/qtwayland.git
QT5WAYLAND_SITE_METHOD = git

QT5WAYLAND_DEPENDENCIES = qt5base qt5jsbackend qt5declarative wayland

QT5WAYLAND_INSTALL_STAGING = YES

define QT5WAYLAND_CONFIGURE_CMDS
	-[ -f $(@D)/Makefile ] && $(MAKE) -C $(@D) distclean
	touch $(@D)/.git
	(cd $(@D) && \
		$(TARGET_MAKE_ENV) \
		$(HOST_DIR)/usr/bin/qmake -r CONFIG+=wayland-compositor)
endef

define QT5WAYLAND_BUILD_CMDS
 	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WAYLAND_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install
endef

define QT5WAYLAND_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5Compositor*.so* $(TARGET_DIR)/usr/lib
	cp -dpf $(STAGING_DIR)/usr/lib/qt/plugins/platforms/libqwayland-brcm-egl.so $(TARGET_DIR)/usr/lib/qt/plugins/platforms/
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/plugins/waylandcompositors $(TARGET_DIR)/usr/lib/qt/plugins/
endef

define QT5WAYLAND_UNINSTALL_TARGET_CMDS
	-rm $(TARGET_DIR)/usr/lib/libQt5Compositor*.so*
	-rm $(TARGET_DIR)/usr/lib/qt/plugins/platforms/libqwayland-brcm-egl.so
	-rm -r $(TARGET_DIR)/usr/lib/qt/plugins/waylandcompositors
endef

$(eval $(generic-package))

