pipeline {
    agent any

    environment {
        IMAGE_NAME = 'geoserver'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker buildx build -t ${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile .
                }
            }
        }

        stage('Run Trivy Scan') {
            steps {
                script {
                    docker run aquasec/trivy image geoserver:latest
                }
            }
        }
    }
}
