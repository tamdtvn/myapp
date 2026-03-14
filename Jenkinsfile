pipeline {
agent {
docker {
image 'mcr.microsoft.com/dotnet/sdk:10.0'
args '-u root'
}
}
environment {
    REGISTRY = "localhost:9001"
    IMAGE_NAME = "myapp"
    IMAGE_TAG = "latest"
}

stages {

    stage('Checkout') {
        steps {
            git 'https://github.com/tamdtvn/myapp.git'
        }
    }

    stage('Restore') {
        steps {
            sh 'dotnet restore'
        }
    }

    stage('Build') {
        steps {
            sh 'dotnet build -c Release'
        }
    }

    stage('Test') {
        steps {
            sh 'dotnet test'
        }
    }

    stage('Publish') {
        steps {
            sh 'dotnet publish -c Release -o publish'
        }
    }
}
}