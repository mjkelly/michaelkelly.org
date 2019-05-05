date=$(shell date)

.PHONY: all
all: install build

.PHONY: build
build:
	rm -rf dist
	mkdir dist
	minify -r --output dist/ www/
	cp -r www/assets dist/assets
	sed -i.bak "s/{{date}}/$(date)/" dist/index.html && rm dist/index.html.bak

.PHONY: install
install:
	env
	go get github.com/tdewolff/minify/cmd/minify
