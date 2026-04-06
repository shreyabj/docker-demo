pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'shreyabj' // Your Docker Hub username
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
        REGISTRY_CREDS = 'dockerhub-creds' 
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Use 'bat' instead of 'sh' for Windows
                    bat "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Login and Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${REGISTRY_CREDS}", passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    // Windows uses different syntax for environment variables in bat
                    bat "echo %PASS% | docker login -u %USER% --password-stdin"
                    bat "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "Successfully pushed to Docker Hub!"
        }
        failure {
            echo "Pipeline failed. Check if Docker Desktop is running!"
        }
    }
}
