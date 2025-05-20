pipeline {
    agent any

    environment {
        IMAGE_NAME = 'calculator-app'
        CONTAINER_NAME = 'calculator-app'
        DOCKER_HUB_USER = 'johnsonbv' // 👈 Replace with your Docker Hub username
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'project-1', url: 'https://github.com/JohnsonBV/proj-mdp-152-155.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build("${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop and remove if already running
                    sh "docker rm -f ${CONTAINER_NAME} || true"

                    // Run new container
                    sh "docker run -d --name ${CONTAINER_NAME} -p 9090:8080 ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        // Login to Docker Hub
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'

                        // Tag and push
                        sh "docker tag ${IMAGE_NAME}:latest $DOCKER_USER/${IMAGE_NAME}:latest"
                        sh "docker push $DOCKER_USER/${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }
}

