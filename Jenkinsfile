pipeline {
	agent any

	environment {
		CYPRESS_IMAGE = "cypress/included:15.5.0"
	}

	stages {
		stage('Checkout') {
			steps {
				git branch: 'main', url: 'https://github.com/edinascimento/cypress-ci-testing.git'
			}
		}

		stage('Debug Workspace') {
			steps {
				sh '''
                    pwd
                    ls -la
                '''
			}
		}

		stage('Run Cypress Tests') {
			steps {
				sh 'chmod +x ./run-cypress.sh && ./run-cypress.sh'
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/videos/**/*.mp4, cypress/screenshots/**/*.png", allowEmptyArchive: true
		}
	}
}