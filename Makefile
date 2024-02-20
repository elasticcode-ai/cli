
.DEFAULT_GOAL := all

.PHONY: clean
clean:
	@echo "Cleaning"
	docker ps -a|grep -v CONTAINER|awk '{ print "docker stop "$1}'| true | sh 2> /dev/null
	docker ps -a|grep -v CONTAINER|awk '{ print "docker rm "$1}'| true | sh 2> /dev/null

.PHONY: up
up:
	docker compose up

.PHONY: build
build:
	docker buildx bake

.PHONY: all
all: clean build