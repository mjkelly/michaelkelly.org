date=$(shell date)

.PHONY: build
build:
	rm -rf dist
	mkdir dist
	minify -r --output dist/ www/
	cp -r www/assets dist/assets
	sed -i.bak "s/{{date}}/$(date)/" dist/index.html && rm dist/index.html.bak

.PHONY: install
install:
	go get github.com/tdewolff/minify/cmd/minify
	@minify --version
