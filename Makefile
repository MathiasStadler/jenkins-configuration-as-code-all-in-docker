ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"
SHELL := /bin/bash

all:


build: build-server

build-server:
	pushd jenkins-server; \
	docker build --file Dockerfile . ; \
	popd 

run-server:
	pushd jenkins-server; \
	docker-compose up; \
	popd

down-server:
	pushd jenkins-server; \
	docker-compose down; \
	popd

bash-server:
	pushd jenkins-server; \
	docker-compose ps -q jenkins >/tmp/jenkins-server-container-id.txt; \
	popd ; \
	jenkins-server/bash-server.sh	