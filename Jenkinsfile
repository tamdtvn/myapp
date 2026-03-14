pipeline {
agent any
environment {
    REGISTRY = "localhost:9001"
    IMAGE_NAME = "myapp"
    IMAGE_TAG = "latest"
    DOTNET_CLI_TELEMETRY_OPTOUT = "1"
}

stages {

    stage('Checkout Source') {
        steps {
            echo "Checking out source code..."
            git branch: 'master', url: 'https://github.com/tamdtvn/myapp.git'
        }
    }

    stage('Restore Dependencies') {
        steps {
            echo "Restoring NuGet packages..."
            sh 'dotnet restore'
        }
    }

    stage('Build Project') {
        steps {
            echo "Building project..."
            sh 'dotnet build --configuration Release --no-restore'
        }
    }

    stage('Run Tests') {
        steps {
            echo "Running tests..."
            sh 'dotnet test --no-build --verbosity normal'
        }
    }

    stage('Publish Application') {
        steps {
            echo "Publishing application..."
            sh 'dotnet publish -c Release -o publish'
        }
    }

    stage('Build Docker Image') {
        steps {
            echo "Building Docker image..."
            sh 'docker build -t $REGISTRY/$IMAGE_NAME:$IMAGE_TAG .'
        }
    }

    stage('Push Docker Image') {
        steps {
            echo "Pushing image to local registry..."
            sh 'docker push $REGISTRY/$IMAGE_NAME:$IMAGE_TAG'
        }
    }

    stage('Deploy to Kubernetes') {
        steps {
            echo "Deploying to Kubernetes..."
            sh 'kubectl apply -f k8s/deployment.yaml'
        }
    }
}

post {

    success {
        echo "Pipeline completed successfully!"
    }

    failure {
        echo "Pipeline failed!"
    }
}
}