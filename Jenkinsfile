
ansiColor('xterm') {
    stage ("xterm"){
      node("") {
         
            stage("Terraform Setup"){


               sh('export PATH=$PATH:/usr/local/bin/')
               sh('make install-terraform')
               dir('terraform'){
                  sh ('ls -larth')
                  //sh('/usr/local/bin/terraform init')
                  sh('terraform init')                 
                  }
            }
            

         
      }
    }
}
