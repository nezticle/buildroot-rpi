#############################################################
#
# gst-omx
#
#############################################################
#GST_OMX_VERSION = 28beb68797c6a260a37bedfa0c0d6026b3dd0a84
#GST_OMX_SITE = http://cgit.freedesktop.org/gstreamer/gst-omx/snapshot/
GST_OMX_VERSION = 07b2fe65d3bcf72d38bbf24453d493d38c359d9c
GST_OMX_SITE = http://cgit.freedesktop.org/~adn770/gst-omx/snapshot/
GST_OMX_SOURCE = gst-omx-$(GST_OMX_VERSION).tar.gz
GST_OMX_INSTALL_STAGING = YES

GST_OMX_POST_DOWNLOAD_HOOKS += GSTREAMER_COMMON_DOWNLOAD
GST_OMX_POST_EXTRACT_HOOKS += GSTREAMER_COMMON_EXTRACT

GST_OMX_DEPENDENCIES = gstreamer gst-plugins-base

GST_OMX_CONF_OPT += \
	--enable-experimental \
	--disable-static

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
GST_OMX_DEPENDENCIES += gst-plugins-bad
GST_OMX_CONF_OPT += --with-omx-target=rpi
GST_OMX_CONF_ENV += CPPFLAGS="$(TARGET_CPPFLAGS) -I$(STAGING_DIR)/usr/include/IL -I$(STAGING_DIR)/usr/include/interface/vcos/pthreads -I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux"
endif

define GST_OMX_UPDATE_CONF
	mkdir -p $(@D)/m4
	$(SED) 's/\/opt\/vc/\/usr/' $(@D)/config/rpi/gstomx.conf
endef

define GST_OMX_RUN_AUTOCONF
	(cd $(@D); \
		LIBTOOLIZE=$(LIBTOOLIZE) \
		ACLOCAL_FLAGS=$(ACLOCAL_FLAGS) \
		ACLOCAL="$(ACLOCAL)" \
		AUTOHEADER=$(AUTOHEADER) \
		AUTOCONF=$(AUTOCONF) \
		AUTOMAKE=$(AUTOMAKE) \
		AUTOM4TE=$(HOST_DIR)/usr/bin/autom4te \
		NOCONFIGURE=1 \
		./autogen.sh --nocheck)
endef

GST_OMX_PRE_CONFIGURE_HOOKS += GST_OMX_RUN_AUTOCONF
GST_OMX_POST_PATCH_HOOKS += GST_OMX_UPDATE_CONF

$(eval $(autotools-package))
