# The default rule must do everything; it's used by Netlify.
.PHONY: all
all: install build

.PHONY: build
build:
	./node_modules/.bin/gulp build

.PHONY: install
install:
	npm install

.PHONY: clean
clean:
	rm -rf ./node_modules
