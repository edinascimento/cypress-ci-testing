pipeline {
	agent any

	stages {
		stage('Checkout') {
			steps {
				git branch: 'main', url: 'https://github.com/edinascimento/cypress-ci-testing.git'
			}
		}

		stage('Build Docker Image') {
			steps {
				sh 'docker build -f Dockerfile -t cypress-tests:latest .'
			}
		}

		stage('Run Cypress Tests') {
			steps {
				sh '''
                echo "=== Starting Cypress Tests ==="
                docker run --name cypress-runner cypress-tests:latest || true

                echo "=== Container finished, checking for reports ==="
                docker exec cypress-runner ls -la /e2e/cypress/ || echo "Could not check /e2e/cypress"

                mkdir -p cypress/reports
                echo "=== Copying reports ==="
                docker cp cypress-runner:/e2e/cypress/reports/. ./cypress/reports/ || echo "No reports to copy"

                echo "=== Local reports directory ==="
                ls -la cypress/reports/

                docker rm cypress-runner || true
             '''
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/reports/**/*", allowEmptyArchive: true
			publishHTML([
				reportDir: 'cypress/reports',
				reportFiles: 'mochawesome.html',
				reportName: 'Cypress Test Report',
				allowMissing: true,
				alwaysLinkToLastBuild: true,
				keepAll: true
			])
		}
	}
}