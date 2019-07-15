ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"
SHELL := /bin/bash

all: build


build: build-server

build-server:
	pushd jenkins-server; \
	docker build --file Dockerfile . ; \
	popd 

run-server:
	pushd jenkins-server; \
	docker-compose up; \
	popd
