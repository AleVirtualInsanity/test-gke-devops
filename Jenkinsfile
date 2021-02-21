
ansiColor('xterm') {
    stage ("xterm"){
      node("") {

            def project_id = "neat-phoenix-305313"
            def app_name = "helloworld-gke"
         
            stage("Deploying simple python web-app via Terraform on a Single GCP istance VM"){
            
                  sh('make install-terraform')

                  dir('terraform/single_istance_vm'){   

                     sh('/usr/local/bin/terraform init')                    
                     sh('/usr/local/bin/terraform plan')     
                     sh('echo yes | /usr/local/bin/terraform apply') 
                     sh('rm -rf .terraform')        

                  }        
            }

            stage("Build and Push image on Docker Container Registry"){
            
                  dir('app'){   
                        sh ('cat CREDENTIALS_FILE.json  | docker login -u _json_key --password-stdin https://gcr.io')
                        sh('gcloud builds submit --tag gcr.io/${project_id}/${app_name}')

                  }        
            }

             stage("Deploying simple python web-app via Terraform on GKE"){
            

                  dir('terraform/kubernetes'){   

                     sh('/usr/local/bin/terraform init')                    
                     sh('/usr/local/bin/terraform plan')     
                     sh('echo yes | /usr/local/bin/terraform apply') 
                     sh('rm -rf .terraform')        

                  }        
            }



      }
    }
}
