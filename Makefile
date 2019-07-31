ROOT_DIR="$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/"
SHELL := /bin/bash

# check shell variables
ifeq ($(DOCKER_HOST_IP),)
$(info variable DOCKER_HOST_IP not set!)
$(info please set variable DOCKER_HOST_IP by hand or run)
$(info . ./set-variables-jenkins-localhost.sh)
exit
endif

# 
# check shell variables
ifeq ($(GITHUB_REPOSITORY),)
$(info variable GITHUB_REPOSITORY not set!)
$(info please set variable GITHUB_REPOSITORY by hand or run)
$(info . ./set-variables-jenkins-localhost.sh)
exit
endif

# check shell variables
ifeq ($(DOCKER_HOST_PORT),)
$(info variable DOCKER_HOST_PORT not set!)
$(info please set variable DOCKER_HOST_PORT by hand or run)
$(info . ./set-variables-jenkins-localhost.sh)
exit
endif

# check shell variables
ifeq ($(COMPOSE_PROJECT_NAME),)
$(info variable COMPOSE_PROJECT_NAME not set!)
$(info please set variable COMPOSE_PROJECT_NAME by hand or run)
$(info . ./start-jenkins.sh for help)
exit
endif

all:

build: build-server

build-service:
	pushd jenkins-server; \
	docker-compose build; \
	popd || ( printf "command failed $$?"; exit 1; )
	

run-service:
	pushd jenkins-server; \
	docker-compose up --detach; \
	popd || ( printf "command failed $$?"; exit 1;)

down-service:
	pushd jenkins-server; \
	docker-compose down; \
	popd || ( printf "command failed $$?"; exit 1;)

bash-service:
	pushd jenkins-server; \
	docker-compose ps -q jenkins >/tmp/jenkins-server-container-id.txt; \
	popd || ( printf "command failed $$?"; exit 1; ) ; \
	jenkins-server/bash-server.sh	

list-service:
	jenkins-server/get-compose-project-name.sh; \
	pushd jenkins-server; \
	docker-compose ps --services; \
	popd

status-service:
	cd $ROOT_DIR;\
	pushd jenkins-server; \
	./get-compose-service-status.sh; \
	popd
	 

list-container:
	jenkins-server/get-compose-project-name.sh; \
	pushd jenkins-server; \
	docker-compose ps; \
	popd

roundtrip-develop:
	make down-service build-service run-service bash-service
	