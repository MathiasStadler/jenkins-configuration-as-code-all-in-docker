multibranchPipelineJob('configuration-as-code') {
    branchSources {
        git {
            id = 'configuration-as-code'
            //remote('https://github.com/jenkinsci/configuration-as-code-plugin.git')
            remote('${GITHUB_URL}')
        }
    }

}