pipeline {
    agent any

    environment {
        IMAGE_NAME = "docker.osgeo.org/geoserver:2.26.2"
        REPORT_JSON = "trivy-results.json"
        REPORT_HTML = "trivy-report.html"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker pull ${IMAGE_NAME}"
                    sh "docker run -d -p 80:8080 ${IMAGE_NAME}"
                }
            }
        }

        stage('Run Trivy Scan') {
            steps {
                script {
                    // Run Trivy scan and save JSON report
                    sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/trivy aquasec/trivy image --format json -o ${REPORT_JSON} ${IMAGE_NAME}"

                    // Generate HTML report using Trivy's template
                    sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/trivy aquasec/trivy -c 'trivy image --format template --template "@contrib/html.tpl" -o ${REPORT_HTML} ${IMAGE_NAME}'"
                }
            }
        }
    }

    post {
        always {
            // Archive reports in Jenkins
            archiveArtifacts artifacts: "${REPORT_JSON}, ${REPORT_HTML}", fingerprint: true

            // Publish HTML report in Jenkins UI
            publishHTML (target: [
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: '.',
                reportFiles: REPORT_HTML,
                reportName: "Trivy Vulnerability Scan Report"
            ])
        }
    }
}
