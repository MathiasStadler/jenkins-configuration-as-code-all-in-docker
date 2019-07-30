# jenkins-configuration-as-code-all-in-docker

a jenkins docker container config by casc ( config-as-code) and run all test inside slave container at remote docke swarm environment

## sources

```txt
https://fishi.devtail.io/weblog/2019/01/06/jenkins-as-code-part-1/
https://jenkins.io/blog/2018/04/25/configuring-jenkins-pipeline-with-yaml-file/
https://jenkinsci.github.io/job-dsl-plugin/#method/javaposse.jobdsl.dsl.helpers.workflow.WorkflowDefinitionContext.cpsScm
# pre approval groovy script
https://stackoverflow.com/questions/43699190/seed-job-asks-for-script-approval-in-jenkins
```

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
