# jenkins-configuration-as-code-all-in-docker
a jenkins docker container config by casc ( config-as-code) and run all test inside slave container at remote  docker swarm environment

## set flag to connect docker via tls

```bash
export DOCKER_HOST="tcp://$(hostname):2376"
export DOCKER_TLS_VERIFY=1
```

