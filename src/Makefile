# $Id: Makefile,v 1.1 2012/02/07 02:08:56 nadya Exp $
#
# @Copyright@
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.1  2012/02/07 02:08:56  nadya
# initial
#

-include $(shell $(ROCKSROOT)/bin/arch).mk
-include $(shell $(ROCKSROOT)/bin/os).mk

SRCDIRS = `find . -maxdepth 1 -type d -not -name CVS -not -name .svn -not -name .`


default:	rpm

copyright pkg rpm clean::
	for i in $(SRCDIRS) ; do \
		(cd $$i; $(MAKE) $@) ; \
	done
