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
                    docker.build('calculator-app:latest')
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    docker.image('calculator-app:latest').run('-p 8080:8080')
                }
            }
        }
    }
}

