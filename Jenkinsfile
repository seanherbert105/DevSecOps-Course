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
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile ."
                }
            }
        }

        stage('Run Trivy Scan') {
            steps {
                script {
                    sh "docker run aquasec/trivy image geoserver:latest"
                }
            }
        }
    }
}
