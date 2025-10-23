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
                mkdir -p cypress/reports
                docker run --rm \
                  -v $(pwd)/cypress/reports:/e2e/cypress/reports \
                  cypress-tests:latest
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
				reportName: 'Cypress Report'
			])
		}
	}
}