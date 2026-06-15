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
    }

    post {
        always {
            echo 'cleaning up workspace'
            deleteDir()
        }
    }
}