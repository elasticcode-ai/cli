.DEFAULT_GOAL := all

.PHONY: format
format:
	eslint --fix "src/**/*.{js,vue}"

.PHONY: lint
lint:
	eslint "src/**/*.{js,vue}"

.PHONY: clean
clean:
	@echo "Cleaning"

.PHONY: docs
docs:
	make -C docs html

.PHONY: install
install:
	. venv/bin/activate && ( \
        pip install -r requirements.txt ; \
        python setup.py install ; \
        python setup.py clean \
        )

.PHONY: build
build:
	SOCKETIO=http://localhost quasar build

.PHONY: all
all: clean lint format build
	git status
