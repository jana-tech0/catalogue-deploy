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
                    env.packageVersion = params.version
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
                sh """
                    cd terraform
                    terraform plan -var="app_version=${packageVersion}"
                """
            }
        }
        stage('Terraform Apply') {
            steps {
                sh """
                    cd terraform
                    terraform apply -auto-approve -var="app_version=${packageVersion}"
                """
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