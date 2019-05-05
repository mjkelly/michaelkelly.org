.PHONY: build
build:
	rm -rf dist
	mkdir dist
	#cp -r www/* dist/
	minify -r --output dist/ www/
	cp -r www/assets dist/assets

.PHONY: install
install:
	go get github.com/tdewolff/minify/cmd/minify
	@minify --version
