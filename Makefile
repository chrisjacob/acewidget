#!/usr/bin/make
# little make file to

PROJECT_NAME=acewidget

all:


build: index_html_build

index_html_build:
	pandoc -A pandoc.header.html -s README.md -o index.html
	sed -i "s/github.com\/you/github.com\/jeromeetienne\/$(PROJECT_NAME)/g" index.html

#################################################################################
#		deploy								#
#################################################################################

deploy:	build deployGhPage

deployGhPage:
	rm -rf /tmp/$(PROJECT_NAME)GhPages
	(cd /tmp && git clone git@github.com:jeromeetienne/$(PROJECT_NAME).git $(PROJECT_NAME)GhPages)
	(cd /tmp/$(PROJECT_NAME)GhPages && git checkout gh-pages)
	cp -a ace/ js/ *.html /tmp/$(PROJECT_NAME)GhPages
	(cd /tmp/$(PROJECT_NAME)GhPages && git add . && git commit -a -m "Another deployement" && git push origin gh-pages)
	#rm -rf /tmp/$(PROJECT_NAME)GhPages
