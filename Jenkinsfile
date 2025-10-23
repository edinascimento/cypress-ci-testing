pipeline {
	agent any

	environment {
		PROJECT_DIR = "cypress-ci-project"
		CYPRESS_IMAGE = "cypress-ci-project-image" // nome da imagem que vamos buildar
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
                    docker build -t ${CYPRESS_IMAGE} "${workspacePath}/${PROJECT_DIR}"
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
                        --entrypoint sh \\
                        -v '${workspacePath}/${PROJECT_DIR}:/e2e' \\
                        -w /e2e \\
                        ${CYPRESS_IMAGE} \\
                        -c 'sh run_cypress.sh'
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