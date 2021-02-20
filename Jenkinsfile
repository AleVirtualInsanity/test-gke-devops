
ansiColor('xterm') {
    stage ("xterm"){
      node("") {
         
            stage("Deploying simple python web-app via Terraform on a Single GCP istance VM"){
            
                  sh('make install-terraform')

                  dir('terraform/single_istance_vm'){   

                     sh('/usr/local/bin/terraform init')                    
                     sh('/usr/local/bin/terraform plan')     
                     sh('echo yes | /usr/local/bin/terraform apply') 
                     sh('rm -rf .terraform')        

                  }        
            }

             stage("Deploying simple python web-app via Terraform on GKE"){
            
                  sh('make install-terraform')

                  dir('terraform/gke'){   

                     sh('/usr/local/bin/terraform init')                    
                     sh('/usr/local/bin/terraform plan')     
                     //sh('echo yes | /usr/local/bin/terraform apply') 
                     sh('rm -rf .terraform')        

                  }        
            }



      }
    }
}
