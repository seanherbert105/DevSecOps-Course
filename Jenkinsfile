pipeline {
    agent any

    stages {
        stage('Run Trivy Scan') {
            steps {
                script {
                    // Run Trivy scan and save JSON report
                    sh '''
                        docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
                        aquasec/trivy image --format json --output trivy-report.json --exit-code 0 python:3.4-alpine
                    '''

                    // Display the report
                    sh 'cat trivy-report.json'
                }
            }
        }
    }
}
