# $Id: Makefile,v 1.2 2012/07/12 20:52:03 nadya Exp $
#
# @Copyright@
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.2  2012/07/12 20:52:03  nadya
# install in bin/
#
# Revision 1.1  2012/02/07 02:08:56  nadya
# initial
#
#

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

version.mk: version.mk.in
	cat version.mk.in ../version.mk > version.mk

build:
	tar xvjf $(NAME)-$(VERSION).tar.bz2

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	$(INSTALL) $(NAME)-$(VERSION)/* $(ROOT)/$(PKGROOT)
	$(INSTALL) -m 0755  autoclickchem_opal_wrapper.sh $(ROOT)/$(PKGROOT)/autoclickchem.sh

clean::
	rm -rf $(NAME)-$(VERSION) 
	rm -rf version.mk
