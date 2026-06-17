pipeline {
    agent { node { label 'agent-1' } }
    environment {
        packageVersion = ''
    }
    parameters {
        string(
            name: 'version',
            defaultValue: '',
            description: 'Which version to Deploy'
        )
    }
    stages {
        stage('Init') {
            steps {
                script {
                    packageVersion = params.version
                    echo "version: ${packageVersion}"
                }
            }
        }
        stage('Terraform Init') {
            steps {
                sh '''
                    cd terraform
                    terraform init -reconfigure
                '''
            }
        }
        stage('Terraform Plan') {
            steps {
                sh '''
                    cd terraform
                    terraform plan
                '''
            }
        }
        stage('Terraform Apply') {
            steps {
                sh '''
                    cd terraform
                    terraform apply -auto-approve
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo "Deployed version: ${packageVersion}"
            }
        }
    }
    post {
        always {
            echo 'cleaning up workspace'
            deleteDir()
        }
    }
}