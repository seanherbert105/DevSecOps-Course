pipeline {
    agent any

    stages {
        stage('Run Trivy Scan') {
            steps {
                script {
                    // Run Trivy scan and save JSON report
                    sh 'docker run --volume /var/run/docker.sock:/var/run/docker.sock aquasec/trivy sbom docker.osgeo.org/geoserver:2.26.2'
                }
            }
        }
    }
}
