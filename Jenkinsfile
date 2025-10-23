pipeline {
	agent any

	environment {
		PROJECT_DIR = ""
		CYPRESS_IMAGE = "cypress-ci-project-image" // nome da imagem que vamos buildar
	}

	stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}

		stage('Debug Workspace') {
			steps {
				sh 'ls -la'
				sh 'pwd'
			}
		}

		stage('Build Docker Image') {
			steps {
				script {
					def workspacePath = pwd()
					sh """
                    docker build -t ${CYPRESS_IMAGE} "${workspacePath}"
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
					  --entrypoint sh \
					  ${CYPRESS_IMAGE} -c "sh run_cypress.sh"
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