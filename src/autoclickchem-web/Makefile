# $Id: Makefile,v 1.2 2012/07/13 01:36:36 nadya Exp $
#
# @Copyright@
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.2  2012/07/13 01:36:36  nadya
# fix sloppy php header
#
# Revision 1.1  2012/02/07 02:08:57  nadya
# initial
#

PKGROOT = /var/www/html/autoclickchem

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

version.mk: version.mk.in
	cat version.mk.in ../version.mk > version.mk

build:
	tar xvjf $(NAME)-$(VERSION).tar.bz2
	patch -p0 < index.php-patch

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	cp -R $(NAME)-$(VERSION)/* $(ROOT)/$(PKGROOT)

clean::
	rm -rf $(NAME)-$(VERSION) $(NAME) 
	rm -rf version.mk


