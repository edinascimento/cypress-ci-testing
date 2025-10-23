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
					sh """
                    docker run --rm -v ${WORKSPACE}:/e2e -w /e2e ${CYPRESS_IMAGE} sh -c "npm ci && npx cypress run --config-file /e2e/cypress.config.js --reporter mochawesome --reporter-options reportDir=cypress/results,overwrite=false,html=false,json=true"
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