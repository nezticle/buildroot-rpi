#############################################################
#
# log4cplus
#
#############################################################

LOG4CPLUS_VERSION = 1.1.0
LOG4CPLUS_SOURCE = log4cplus-$(LOG4CPLUS_VERSION).tar.bz2
LOG4CPLUS_SITE = http://downloads.sourceforge.net/project/log4cplus/log4cplus-stable/$(LOG4CPLUS_VERSION)
LOG4CPLUS_INSTALL_STAGING = YES
LOG4CPLUS_INSTALL_TARGET = YES

$(eval $(autotools-package))
