job('init-add-docker-cloud') {
    // steps {
    //     systemGroovyCommand(readFileFromWorkspace('add-docker-cloud.groovy')) {
    //         binding('computerName', 'ubuntu-04')
    //     }
    //}
    steps {

        printf "Hallo World\n"
        println("script directory: ${new File(__FILE__).parent.absolutePath}")
    }


    
}