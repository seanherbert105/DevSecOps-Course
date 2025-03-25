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
                    sh "/usr/bin/docker docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile ."
                }
            }
        }

        stage('Run Trivy Scan') {
            steps {
                script {
                    sh "/usr/bin/docker docker run aquasec/trivy image geoserver:latest"
                }
            }
        }
    }
}
