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
				script {
					def workspacePath = pwd()
					sh """
                    docker run --rm -v /var/jenkins_home/workspace/Cypress-ci-testing:/e2e -w /e2e cypress/included:15.5.0 sh -c "npm ci && npx cypress run --config-file /e2e/cypress.config.js --reporter mochawesome --reporter-options reportDir=cypress/results,overwrite=false,html=false,json=true"
                    """
				}
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/videos/**/*.mp4, cypress/screenshots/**/*.png", allowEmptyArchive: true
		}
	}
}