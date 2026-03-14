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
            git branch: 'master',
            url: 'https://github.com/tamdtvn/myapp.git'
        }
    }

    stage('Restore Dependencies') {
        agent {
            docker {
                image 'mcr.microsoft.com/dotnet/sdk:10.0'
                args '-u root'
            }
        }
        steps {
            sh 'dotnet restore'
        }
    }

    stage('Build Project') {
        agent {
            docker {
                image 'mcr.microsoft.com/dotnet/sdk:10.0'
                args '-u root'
            }
        }
        steps {
            sh 'dotnet build -c Release --no-restore'
        }
    }

    stage('Publish Project') {
        agent {
            docker {
                image 'mcr.microsoft.com/dotnet/sdk:10.0'
                args '-u root'
            }
        }
        steps {
            sh 'dotnet publish -c Release -o publish'
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
            docker run -d -p 50000:80 --name myapp-test ${IMAGE_NAME}:${IMAGE_TAG}
            '''
        }
    }

}

post {
    success {
        echo 'CI/CD Pipeline completed successfully!'
    }
    failure {
        echo 'Pipeline failed.'
    }
}

}