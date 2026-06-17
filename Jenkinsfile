pipeline {
    agent {
        node {
            label 'agent-1'
        }
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
                sh '''
                    cd terraform
                    terraform init -reconfigure
                '''
            }
        }

        stage('Plan') {
            steps {
                sh """
                    cd terraform
                    terraform plan -var="version=${params.version}"
                """
            }
        }

        stage('Apply') {
            steps {
                sh """
                    cd terraform
                    terraform apply -auto-approve -var="version=${params.version}"
                """
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying version: ${params.version}"
            }
        }
    }

    post {
        always {
            deleteDir()
        }
    }
}