ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"
SHELL="/bin/bash"

all: build


build:

build-server:
	pushd jenkins-server; \
	docker build --file Dockerfile . ; \
	popd


run-server:
	docker-compose up
