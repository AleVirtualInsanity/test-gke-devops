
ansiColor('xterm') {
    stage ("xterm"){
      node("") {
         
            stage("Install Terraform"){
                  echo 'Alessio CICD starts:'
                  
                  sh('make install-terraform')
                  dir('terraform'){
                     sh ('ls -larth')
                     sh('/usr/local/bin/terraform init')
                     sh('/usr/local/bin/terraform plan')
                  
                  }
            }
            

         
      }
    }
}
