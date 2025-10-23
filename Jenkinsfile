pipeline {
	agent any

	environment {
		PROJECT_DIR = "cypress-ci-testing"
		CYPRESS_IMAGE = "cypress/included:15.5.0"
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
                        ./run_cypress.sh
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