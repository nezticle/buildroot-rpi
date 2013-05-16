#############################################################
#
# International Components for Unicode
#
#############################################################

ICU_VERSION = 4.8.1.1
ICU_SOURCE = icu4c-$(subst .,_,$(ICU_VERSION))-src.tgz
ICU_SITE = http://download.icu-project.org/files/icu4c/$(ICU_VERSION)
ICU_LICENSE = ICU License
ICU_LICENSE_FILES = license.html

ICU_DEPENDENCIES = host-icu
ICU_INSTALL_STAGING = YES
ICU_CONFIG_SCRIPTS = icu-config
ICU_CONF_OPT = \
	--with-cross-build=$(HOST_ICU_DIR)/source \
	--disable-samples \
	--disable-tests
HOST_ICU_CONF_OPT = \
	--disable-samples \
	--disable-tests \
	--disable-extras \
	--disable-icuio \
	--disable-layout
ICU_MAKE = $(MAKE1)
ICU_SUBDIR = source
HOST_ICU_SUBDIR = source

ifeq ($(BR2_PACKAGE_ICU_MINIMIZED),y)
ICU_CONF_OPT += \
	--disable-extras \
	--disable-icuio \
	--disable-layout
endif

define ICU_MINIMIZE
	cp package/icu/icudt48l.dat $(@D)/source/data/in/
endef

ifeq ($(BR2_PACKAGE_ICU_MINIMIZED),y)
ICU_POST_EXTRACT_HOOKS += ICU_MINIMIZE
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
