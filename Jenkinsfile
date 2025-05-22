pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "johnsonbv/calculator:latest"
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/JohnsonBV/java-web-calculator.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'johnsonbv-creds-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl apply -f k8s-deployment.yml
                        kubectl apply -f k8s-service.yml
                    '''
                }
            }
        }
    }
}

