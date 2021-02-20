
ansiColor('xterm') {
    stage ("xterm"){
      node("") {
         
         
            stage("Terraform Setup"){

            
               
                  sh('export PATH=$PATH:/usr/local/bin/terraform')
                  //sh('export API_KEY=AIzaSyBmwXdtBXgKnVoJVc0wCq8lB6Zd_WRz6rQ')

                  sh('make install-terraform')
                  dir('terraform'){

                     sh ('ls -larth')

                     sh('/usr/local/bin/terraform init')
                     
                     sh('/usr/local/bin/terraform plan')     

                     sh('export API_KEY=AIzaSyBmwXdtBXgKnVoJVc0wCq8lB6Zd_WRz6rQ; echo yes | /usr/local/bin/terraform apply') 

                     sh('rm -rf .terraform')        

                  }
               
            }

         
      }
    }
}
