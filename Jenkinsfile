
ansiColor('xterm') {
    stage ("xterm"){
      node("") {

            def project_id    = "neat-phoenix-305313"
            def app_name   = "helloworld-gke"
            def tf_env_path = "/usr/local/bin/"
            def gcloud_env_path = "/var/lib/snapd/snap/bin/"
            def gcloud_auth = ""
            def account_email = "alessio.iodice37@gmail.com"
         
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

                        sh (" '${gcloud_env_path}'gcloud auth login --no-launch-browser  ")

                        timeout(time: 300, unit: 'SECONDS') {
                              gcloud_auth = input
                              (
                                    id: 'gcloud_auth', message: 'Please provide GCLOUD returned Token: ', parameters: 
                                    [ [$class: 'TextParameterDefinition', defaultValue: '', description: '', name: 'GCLOUD_AUTH:'] ]
                              )
                        }

                        //sh ('cat CREDENTIALS_FILE.json  | docker login -u _json_key --password-stdin https://gcr.io')
                        //sh("'${gcloud_env_path}'gcloud config set project '${project_id}'")
                        //sh("'${gcloud_env_path}'gcloud config set account '${account_email}' ")
                        //sh("'${gcloud_env_path}'gcloud builds submit --tag gcr.io/'${project_id}'/'${app_name}' ")
                  }        
            }
            /*
             stage("Deploying HelloWorld  via Terraform on GKE pod"){
            

                  dir('terraform/kubernetes'){   

                     sh("'${tf_env_path}'terraform init")                    
                     sh("'${tf_env_path}'terraform plan")    
                     sh(" echo yes | '${tf_env_path}'terraform apply")   
                     sh('rm -rf .terraform')         

                  }        
            }
            */


      }
    }
}
