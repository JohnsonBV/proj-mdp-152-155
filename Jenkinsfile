pipeline {
    agent any

    environment {
        IMAGE_NAME = 'calculator-app'
        IMAGE_TAG = 'latest'
        CONTAINER_PORT = '8080'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'project-1', url: 'https://github.com/JohnsonBV/proj-mdp-152-155.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Clean up old containers
                    sh "docker rm -f ${IMAGE_NAME} || true"

                    // Run the new container
                    app.run("-d --name ${IMAGE_NAME} -p ${CONTAINER_PORT}:${CONTAINER_PORT}")
                }
            }
        }
    }
}

