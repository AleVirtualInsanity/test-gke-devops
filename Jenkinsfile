
ansiColor('xterm') {
    stage ("xterm"){
      node("") {
         
            stage("Terraform Setup"){


               sh('export PATH=$PATH:/usr/local/bin/terraform')
               sh('make install-terraform')
               dir('terraform'){

                  sh ('ls -larth')

                  sh('/usr/local/bin/terraform init')
                  
                  sh('/usr/local/bin/terraform plan')     

                  sh('/usr/local/bin/terraform apply') 

                  sh('rm -rf .terraform')        

                  }
            }
            

         
      }
    }
}
