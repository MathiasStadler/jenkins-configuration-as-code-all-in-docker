ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"


all: build


build: build-server

build-server:
	docker build --file jenkins-server/Dockerfile .

run-server:
	docker-compose up 
