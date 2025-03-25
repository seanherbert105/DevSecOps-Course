pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker pull docker.osgeo.org/geoserver:2.26.2'
                    sh 'docker run -p 80:8080 docker.osgeo.org/geoserver:2.26.2'
                }
            }
        }

        stage('Run Trivy Scan') {
            steps {
                script {
                    sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image docker.osgeo.org/geoserver:2.26.2'
                }
            }
        }
    }
}
