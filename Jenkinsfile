pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/tamdtvn/myapp.git'
            }
        }

        stage('Build') {
            steps {
                sh 'echo Building project...'
            }
        }

        stage('Test') {
            steps {
                sh 'echo Running tests...'
            }
        }

    }
}