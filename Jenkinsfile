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

		stage('Run Cypress Tests') {
			steps {
				script {
					def workspacePath = pwd()  // diretório do clone do GitHub
					sh """
                    docker run --rm \\
                        -v "${workspacePath}:${workspacePath}" \\
                        -w ${workspacePath} \\
                        ${CYPRESS_IMAGE} \\
                        sh -c "npm ci && npx cypress run --config-file ${workspacePath}/cypress.config.js --reporter mochawesome --reporter-options 'reportDir=cypress/results,overwrite=false,html=false,json=true'"
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