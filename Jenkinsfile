pipeline {
    agent any

    environment {
        // Change these to your actual Docker Hub details
        DOCKER_HUB_USER = 'shreyabj'
        IMAGE_NAME = 'myapp'
        IMAGE_TAG = 'latest'
        // This ID must match the ID you created in Jenkins Credentials
        REGISTRY_CREDS = 'dockerhub-creds' 
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pulls the latest code from your GitHub repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Builds the image using the HTML Dockerfile in your folder
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Login and Push to Docker Hub') {
            steps {
                // Securely logs into Docker Hub using the credentials stored in Jenkins
                withCredentials([usernamePassword(credentialsId: "${REGISTRY_CREDS}", passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "echo ${PASS} | docker login -u ${USER} --password-stdin"
                    sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "Successfully pushed ${IMAGE_NAME} to Docker Hub!"
        }
        failure {
            echo "Pipeline failed. Check the console output for errors."
        }
    }
}
