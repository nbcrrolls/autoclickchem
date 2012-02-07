# 
# $Id: Makefile,v 1.1 2012/02/07 02:08:57 nadya Exp $
#
# @Copyright@
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.1  2012/02/07 02:08:57  nadya
# initial
#

PKGROOT = /var/www/html/roll-documentation/autoclickchem/$(VERSION)

REDHAT.ROOT     = $(PWD)/../../
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

SEDSPEC += \
        -e 's%@PUBDATE@%$(PUBDATE)%g' \
        -e 's%@YEAR@%$(YEAR)%g' \
        -e 's%@NAME@%$(NAME)%g' \
        -e 's%@VERSION@%$(VERSION)%g' \
        -e 's%@ROCKS_VERSION@%$(ROCKS_VERSION)%g' 

default: $(NAME).spec 

html: predoc
	jw --backend html --dsl $(PWD)/rocks.dsl#html index.sgml 

pdf: predoc
	jw --backend pdf --dsl $(PWD)/rocks.dsl#print index.sgml

build: html pdf

install:: build
	mkdir -p $(ROOT)/$(PKGROOT)/images
	mkdir -p $(ROOT)/$(PKGROOT)/stylesheet-images
	install -ma+r index.pdf 	$(ROOT)/$(PKGROOT)/$(NAME).pdf
	install -ma+r *.html    	$(ROOT)/$(PKGROOT)/
	install -ma+r images/*.png	$(ROOT)/$(PKGROOT)/images/
	install -ma+r stylesheet-images/{*.gif,*.png} \
		$(ROOT)/$(PKGROOT)/stylesheet-images/
	install -ma+r rocks.css $(ROOT)/$(PKGROOT)/

clean::
	rm -f *.html
	rm -f index.pdf


