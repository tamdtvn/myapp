pipeline {

    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
            git 'https://github.com/tamdtvn/myapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
            sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Tag Latest') {
            steps {
            sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
            }
        }

        stage('Deploy Kubernetes') {
            steps {
            sh """
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
            """
        }
        }

    }

}