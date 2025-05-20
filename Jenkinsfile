pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git branch: 'project-1', url: 'https://github.com/JohnsonBV/proj-mdp-152-155.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build('calculator-app:latest')
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop and remove the old container if it exists
                    sh 'docker rm -f calculator-app || true'

                    // Run a new container on port 9090 to avoid conflict with Jenkins
                    sh 'docker run -d --name calculator-app -p 9090:8080 calculator-app:latest'
                }
            }
        }
    }
}

