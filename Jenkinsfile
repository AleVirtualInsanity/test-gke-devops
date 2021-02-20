
ansiColor('xterm') {
    stage ("xterm"){
      node("") {
         
         
            stage("Terraform Setup"){

            
               
                  sh('export PATH=$PATH:/usr/local/bin/terraform')


                  sh('make install-terraform')
                  dir('terraform'){

                     sh ('cat /root/.ssh/id_rsa.pub')
                     

                     //sh('/usr/local/bin/terraform init')
                     
                     //sh('/usr/local/bin/terraform plan')     

                     //sh('echo yes | /usr/local/bin/terraform apply') 

                     sh('rm -rf .terraform')        

                  }
               
            }

         
      }
    }
}
