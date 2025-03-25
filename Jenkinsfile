pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'sudo docker buildx create --use || true' // Ensure buildx is available
                    sh 'sudo docker buildx build --load -t geoserver:latest -f Dockerfile.geoserver .'
                }
            }
        }

        stage('Run Trivy Scan') {
            steps {
                script {
                    sh 'sudo docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image geoserver:latest'
                }
            }
        }
    }
}
