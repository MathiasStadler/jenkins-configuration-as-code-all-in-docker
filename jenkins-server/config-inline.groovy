multibranchPipelineJob('configuration-as-code') {
    branchSources {
        git {
            id = 'configuration-as-code'
            //remote('https://github.com/jenkinsci/configuration-as-code-plugin.git')
            remote("${GITHUB_URL}")
        }
    }
    configure {
        it / 'triggers' << 'com.cloudbees.hudson.plugins.folder.computed.PeriodicFolderTrigger' {
            spec '* * * * *'
            interval "60000"
        }
    }

}