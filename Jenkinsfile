pipeline {
	agent any

	environment {
		PROJECT_DIR = "cypress-ci-testing"
		CYPRESS_IMAGE = "cypress/included:13.12.0"
	}

	stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}

		stage('Run Cypress inside Docker') {
			steps {
				script {
					def workspacePath = pwd()
					sh """
                    docker run --rm \\
                        -v '${workspacePath}/${PROJECT_DIR}:/e2e' \\
                        -w /e2e \\
                        ${CYPRESS_IMAGE} \\
                        sh -c 'npm ci && npx cypress run --browser chrome --headless'
                    """
				}
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "${PROJECT_DIR}/cypress/videos/**, ${PROJECT_DIR}/cypress/screenshots/**", allowEmptyArchive: true
		}
	}
}