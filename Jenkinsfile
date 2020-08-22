pipeline {
    agent any

    stages {
        stage ('init & plan') {

            steps {
                
                    sh 'terraform init'
                    sh 'terraform plan'
                
            }
        }

        stage ('apply Stage') {

            steps {
               sh 'terraform apply'
            }
        }


    }
}