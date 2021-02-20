
ansiColor('xterm') {
    stage ("xterm"){
      node("") {

            stage('Checkout code') {
                  steps {
                        checkout scm
                  }
            }
         
            stage("Terraform Setup of a Single GCP istance VM"){
            
                  sh('make install-terraform')

                  dir('terraform/single_istance_vm'){   

                     sh('/usr/local/bin/terraform init')                    
                     sh('/usr/local/bin/terraform plan')     
                     sh('echo yes | /usr/local/bin/terraform apply') 
                     sh('rm -rf .terraform')        

                  }
               
            }
      }
    }
}
