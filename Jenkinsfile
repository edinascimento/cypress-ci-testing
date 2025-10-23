pipeline {
	agent any

	environment {
		CYPRESS_IMAGE = "cypress/included:15.5.0"
	}

	stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}

		stage('Build Docker Image') {
			steps {
				script {
					def workspacePath = pwd()
					sh """
                    docker build -t cypress-ci-project-image \
                        "${workspacePath}"
                    """
				}
			}
		}

		stage('Run Cypress Tests') {
			steps {
				script {
					def workspacePath = pwd()
					sh """
                    docker run --rm \
                        -v "${workspacePath}:/e2e" \
                        -w /e2e \
                        ${CYPRESS_IMAGE} \
                        sh -c "npm ci && npm run test:ci"
                    """
				}
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/videos/**/*.mp4, cypress/screenshots/**/*.png",
			allowEmptyArchive: true
		}
	}
}