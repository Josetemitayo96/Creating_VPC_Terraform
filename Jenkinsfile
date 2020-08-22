pipeline {
    agent any


    stages {


     stage('Install TF Dependencies') {
      steps{
        sh "sudo apt install wget zip python-pip -y"
        sh "sudo curl -o terraform.zip https://releases.hashicorp.com/terraform/0.12.5/terraform_0.12.5_linux_amd64.zip"
        sh "sudo unzip terraform.zip"
        sh "sudo mv terraform /usr/bin"
        sh "sudo rm -rf terraform.zip"
      }       
    }

        stage ('init & plan') {

            steps {
                
                    sh 'terraform init'
                    
                
            }
        }

        stage ('apply Stage') {

            steps {
               sh 'terraform apply --auto-approve'
            }
        }


    }
}