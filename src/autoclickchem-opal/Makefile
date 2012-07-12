# $Id: Makefile,v 1.2 2012/07/12 18:54:01 nadya Exp $
#
# @Copyright@
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.2  2012/07/12 18:54:01  nadya
# user version in service name
#
# Revision 1.1  2012/02/07 02:08:56  nadya
# initial
#

PKGROOT      = /opt/autoclickchem
PKGROOT_OPAL = /opt/opal/deployed


REDHAT.ROOT = $(PWD)/../../
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

version.mk: version.mk.in
	cat version.mk.in ../version.mk > version.mk

build::
	tar xvjf $(NAME)-submit-$(VERSION).tar.bz2

install::
	mkdir -p $(ROOT)/$(PKGROOT)/opal_submit
	mkdir -p $(ROOT)/$(PKGROOT_OPAL)
	$(INSTALL)  -m 0644  autoclickchem_config.xml $(ROOT)/$(PKGROOT_OPAL)/autoclickchem_$(VERSION).xml
	$(INSTALL) $(NAME)-submit/* $(ROOT)/$(PKGROOT)/opal_submit

clean::
	rm -rf $(NAME)-$(VERSION) 
	rm -rf version.mk
