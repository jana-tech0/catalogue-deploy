pipeline {
    agent { node { label 'agent-1' } }
    parameters {
        string(
            name: 'version',
            defaultValue: 'NONE',
            description: 'Which version to Deploy'
        )
    }
    stages {
        stage('Init') {
            steps {
                script {
                    if (!params.version) {
                        error "version parameter is required!"  // ← ADDED: fail fast
                    }
                    echo "version: ${params.version}"
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
                    terraform plan -var="app_version=${params.version}"  
                """
            }
        }
        stage('Terraform Apply') {
            steps {
                sh """
                    cd terraform
                    terraform apply -auto-approve -var="app_version=${params.version}"
                """
            }
        }
        stage('Deploy') {
            steps {
                echo "Deployed version: ${params.version}"
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