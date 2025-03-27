pipeline {
    agent any

    stages {
        stage('Run Trivy Scan') {
            steps {
                script {
                    // Pull Goeserver image
                    sh 'docker pull docker.osgeo.org/geoserver:2.26.2'
                    
                    // Run Trivy scan and save JSON report
                    sh 'docker run --volume /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image docker.osgeo.org/geoserver:2.26.2'
                }
            }
        }
    }
}
