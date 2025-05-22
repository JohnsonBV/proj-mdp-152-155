pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "johnsonbv/yourapp:latest"
        KUBECONFIG_CREDENTIALS_ID = "kubeconfig-creds"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'project-3', url: 'https://github.com/JohnsonBV/proj-mdp-152-155.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'johnsonbv-creds-id', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIALS_ID}", variable: 'KUBECONFIG')]) {
                    sh 'kubectl --kubeconfig=$KUBECONFIG apply -f k8s-deployment.yaml'
                    sh 'kubectl --kubeconfig=$KUBECONFIG apply -f k8s-service.yaml'
                }
            }
        }
    }
}

