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
                docker run --name cypress-runner cypress-tests:latest || true

                mkdir -p cypress/reports
                docker cp cypress-runner:/e2e/cypress/reports/. ./cypress/reports/ || true

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