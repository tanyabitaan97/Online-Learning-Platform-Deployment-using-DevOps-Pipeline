pipeline {
    agent any

    environment {
        IMAGE_NAME = 'online-learning-platform'
        CONTAINER_NAME = 'online-learning-platform'
        HOST_PORT = '8080'
        CONTAINER_PORT = '80'
    }

    stages {

        stage('Checkout') {
            steps {
                // If Jenkins is connected to Git, use:
                // checkout scm
                echo 'Source code is already available in the workspace'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                    docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    docker run -d                       --name ${CONTAINER_NAME}                       -p ${HOST_PORT}:${CONTAINER_PORT}                       ${IMAGE_NAME}:${BUILD_NUMBER}
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    sleep 3
                    curl -f http://localhost:${HOST_PORT}
                '''
            }
        }
    }

    post {
       
        failure {
            echo "Deployment failed. Check the Jenkins console log."
        }

        always {
            sh '''
                docker ps -a --filter "name=${CONTAINER_NAME}" || true
            '''
        }
    }
}
