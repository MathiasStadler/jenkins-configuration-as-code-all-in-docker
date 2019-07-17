ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"
SHELL := /bin/bash

all:


build: build-server

build-service:
	pushd jenkins-server; \
	docker build --file Dockerfile . ; \
	popd 

run-service:
	pushd jenkins-server; \
	docker-compose up --detach; \
	popd

down-service:
	pushd jenkins-server; \
	docker-compose down; \
	popd

bash-service:
	pushd jenkins-server; \
	docker-compose ps -q jenkins >/tmp/jenkins-server-container-id.txt; \
	popd ; \
	jenkins-server/bash-server.sh	

list-service:
	jenkins-server/get-compose-project-name.sh; \
	pushd jenkins-server; \
	docker-compose ps --services; \
	popd