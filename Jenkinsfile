
ansiColor('xterm') {
    stage ("xterm"){
      node("") {

            def project_id    = "neat-phoenix-305313"
            def app_name   = "helloworld-gke"
            def tf_env_path = "/usr/local/bin/"
         
            stage("Deploying HelloWorld via Terraform on a Single GCP istance VM"){
            
                  sh('make install-terraform')

                  dir('terraform/single_istance_vm'){   

                     sh("'${tf_env_path}'terraform init")                    
                     sh("'${tf_env_path}'terraform plan")    
                     sh(" echo yes | '${tf_env_path}'terraform apply")   
                     sh('rm -rf .terraform')        

                  }        
            }

            stage("Build and Push image on Docker Container Registry"){
            
                  dir('app'){   
                        //sh ('cat CREDENTIALS_FILE.json  | docker login -u _json_key --password-stdin https://gcr.io')
                        //sh("/var/lib/snapd/snap/bin/gcloud config set project '${project_id}'")
                        //sh("/var/lib/snapd/snap/bin/gcloud config set account alessio.iodice37@gmail.com")
                        //sh("/var/lib/snapd/snap/bin/gcloud builds submit --tag gcr.io/'${project_id}'/'${app_name}' ")
                        
                  }        
            }

             stage("Deploying HelloWorld  via Terraform on GKE pod"){
            

                  dir('terraform/kubernetes'){   

                     sh("'${tf_env_path}'terraform init")                    
                     sh("'${tf_env_path}'terraform plan")    
                     sh(" echo yes | '${tf_env_path}'terraform apply")   
                     sh('rm -rf .terraform')         

                  }        
            }


      }
    }
}
