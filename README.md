# jenkins-configuration-as-code-all-in-docker

a jenkins docker container config by casc ( config-as-code) and run all test inside slave container at remote  docker swarm environment

## tl;dr

- check out these repo
- run start-jenkins.sh and follow up that instruction

## version tags

- v0.0.1
[x] start/stop Jenkins container trigger by make
[x] remote access to docker socket via tls 
[x] inline docker key per secret inside the remote container
[x] config casc to git checkout project.dsl from poroject
[x] handle by docker-compose
[x] Security: No export docker socket to conatiner
[x] Security: Container not run in under privileged mode
