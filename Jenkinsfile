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
                docker run --name cypress-container cypress-tests:latest
                docker cp cypress-container:/e2e/cypress/videos ./cypress/ || true
                docker cp cypress-container:/e2e/cypress/screenshots ./cypress/ || true
                docker rm cypress-container
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