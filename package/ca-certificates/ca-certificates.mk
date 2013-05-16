#############################################################
#
# ca-certificates
#
#############################################################
CA_CERTIFICATES_VERSION = 1.0.0
CA_CERTIFICATES_SITE = $(TOPDIR)/package/ca-certificates/bin
CA_CERTIFICATES_SITE_METHOD = local

define CA_CERTIFICATES_INSTALL_TARGET_CMDS
	$(@D)/mkcabundle.pl > $(@D)/ca-bundle.crt
	mkdir -p $(TARGET_DIR)/etc/ssl/certs
	mkdir -p $(TARGET_DIR)/etc/ssl/CA/private
	cp $(@D)/ca-bundle.crt $(TARGET_DIR)/etc/ssl/certs/
	(cd $(TARGET_DIR)/etc/ssl; \
		ln -sf certs/ca-bundle.crt cert.pem; \
	)
endef

$(eval $(generic-package))
