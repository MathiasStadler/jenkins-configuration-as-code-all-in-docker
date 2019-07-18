ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"
SHELL := /bin/bash

# check shell variables
ifeq ($(DOCKER_HOST_IP),)
$(info variable DCKER_HOST_IP not set!)
$(info please set variable DOCKER_HOST_IP by hand or run)
$(info . ./set-docker-host-ip.sh)
exit
endif

# check shell variables
ifeq ($(DOCKER_HOST_PORT),)
$(info variable DOCKER_HOST_PORT not set!)
$(info please set variable DOCKER_HOST_PORT by hand or run)
$(info . ./set-docker-host-ip.sh)
exit
endif

# check shell variables
ifeq ($(COMPOSE_PROJECT_NAME),)
$(info variable COMPOSE_PROJECT_NAME not set!)
$(info please set variable COMPOSE_PROJECT_NAME by hand or run)
$(info ./start-jenkins.sh for help)
exit
endif


all:


build: build-server

build-service:
	pushd jenkins-server; \
	docker-compose build; \
	popd;
	

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

status-service:
	pushd jenkins-server; \
	./get-compose-service-status.sh; \
	popd; 

list-container:
	jenkins-server/get-compose-project-name.sh; \
	pushd jenkins-server; \
	docker-compose ps; \
	popd

rountrib-develop:
	make down-service
	make build-service
	make run-service
	make bash-service
	
	
