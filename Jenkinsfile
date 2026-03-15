pipeline {

agent any

environment {
    IMAGE_NAME = "myapp"
    IMAGE_TAG = "${BUILD_NUMBER}"
}

stages {

    stage('Clean Workspace') {
        steps {
            deleteDir()
        }
    }

    stage('Checkout Code') {
        steps {
            git 'https://github.com/tamdtvn/myapp.git'
        }
    }

    stage('Build Docker Image') {
        steps {
            sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
        }
    }

    stage('Run Container Test') {
        steps {
            sh '''
            docker rm -f myapp-test || true
            docker run -d -p 9000:80 --name myapp-test ${IMAGE_NAME}:${IMAGE_TAG}
            '''
        }
    }

}

}