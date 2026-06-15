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

        stage('Deploy') {
            steps {
                echo "Deploying..."
                echo "Version Received: ${params.version}"
            }
        }
    

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
    }

    post {
        always {
            echo 'cleaning up workspace'
            deleteDir()
        }
    }
}