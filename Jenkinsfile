pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker buildx build -t geoserver -f Dockerfile.geoserver .
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
