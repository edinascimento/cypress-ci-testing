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
                docker run --rm \\
                   -v "${workspacePath}/cypress/videos:/app/cypress/videos" \\
                   -v "${workspacePath}/cypress/screenshots:/app/cypress/screenshots" \\
                   ${CYPRESS_IMAGE}
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