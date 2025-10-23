pipeline {
	agent any

	environment {
		CYPRESS_IMAGE = "cypress/included:15.5.0"
	}

	stages {
		stage('Run Cypress Tests') {
			steps {
				script {
					def workspacePath = pwd()
					sh """
                    docker run --rm \\
                        -v "${workspacePath}:/e2e" \\
                        -w /e2e \\
                        ${CYPRESS_IMAGE} \\
                        sh -c "npm ci && npx cypress run --reporter mochawesome --reporter-options 'reportDir=cypress/results,overwrite=false,html=false,json=true'"
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