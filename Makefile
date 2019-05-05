.PHONY: build
build:
	npm install && ./node_modules/.bin/gulp build


.PHONY: clean
clean:
	rm -rf ./node_modules
