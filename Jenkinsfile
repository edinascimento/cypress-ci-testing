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
                        \"${workspacePath}\"
                    """
				}
			}
		}

		stage('Debug Workspace') {
			steps {
				sh 'ls -la'
				sh 'pwd'
			}
		}

		stage('Run Cypress Tests') {
			steps {
				script {
					def workspacePath = pwd()
					sh """
                    docker run --rm \
                        --entrypoint sh \
                        -v \"${workspacePath}:/e2e\" \
                        -w /e2e \
                        cypress-ci-project-image \
                        -c \"sh run_cypress.sh\"
                    """
				}
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/videos/**, cypress/screenshots/**", allowEmptyArchive: true
		}
	}
}