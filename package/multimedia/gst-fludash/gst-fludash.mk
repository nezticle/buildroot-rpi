#############################################################
#
# gst-fludash
#
#############################################################
GST_FLUDASH_VERSION = 1.0.0
GST_FLUDASH_SOURCE = gst-fludash-$(GST_FLUDASH_VERSION).tar.gz
GST_FLUDASH_SITE = http://build.metrological.com/rpi/

GST_FLUDASH_DEPENDENCIES += libcurl

define GST_FLUDASH_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/gstreamer-0.10
	$(INSTALL) -m 755 $(@D)/usr/lib/libfludownloader.so $(TARGET_DIR)/usr/lib/libfludownloader.so.0.0.0
	$(INSTALL) -m 755 $(@D)/usr/lib/gstreamer-0.10/libgstfluaacdec.so $(TARGET_DIR)/usr/lib/gstreamer-0.10/
	$(INSTALL) -m 755 $(@D)/usr/lib/gstreamer-0.10/libgstfludash.so $(TARGET_DIR)/usr/lib/gstreamer-0.10/
	(cd $(TARGET_DIR)/usr/lib/; \
		ln -sfn libfludownloader.so.0.0.0 libfludownloader.so.0; \
		ln -sfn libfludownloader.so.0 libfludownloader.so; \
	)
endef

$(eval $(generic-package))
