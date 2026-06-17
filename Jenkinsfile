pipeline {
    agent {
        node {
            label 'agent-1'
        }
    }

    parameters {
        string(
            name: 'version',
            defaultValue: '1.0.1',
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
                sh '''
                    cd terraform
                    terraform plan
                '''
            }
        }

        stage('Apply') {
            steps {
                sh '''
                    cd terraform
                    terraform destroy -auto-approve
                '''
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