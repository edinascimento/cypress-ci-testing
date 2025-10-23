pipeline {
	agent any

	stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}

		stage('Build Cypress Image') {
			steps {
				sh 'docker build -f Dockerfile -t cypress-tests:latest .'
			}
		}

		stage('Run Cypress Tests') {
			steps {
				sh '''
                docker run --rm \
                  -v $(pwd):/e2e \
                  -w /e2e \
                  cypress-tests:latest \
                  npx cypress run --config-file /e2e/cypress.config.js
             '''
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/videos/**/*.mp4, cypress/screenshots/**/*.png", allowEmptyArchive: true
		}
	}
}