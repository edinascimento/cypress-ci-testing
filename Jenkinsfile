pipeline {
	agent any

	environment {
		PROJECT_DIR = "cypress-ci-testing"
		CYPRESS_IMAGE = "cypress/included:15.5.0"
	}

	stages {
		stage('Checkout') {
			steps {
				// Clona o repositório
				checkout scm
			}
		}

		stage('Run Cypress inside Docker') {
			steps {
				// Roda Cypress dentro do container usando shell
				sh '''
                docker run --rm \
                    --entrypoint sh \
                    -v "$PWD/${PROJECT_DIR}:/e2e" \
                    -w /e2e \
                    $CYPRESS_IMAGE \
                    -c "npm ci && npx cypress run --browser chrome --headless"
                '''
			}
		}
	}

	post {
		always {
			// Arquiva vídeos e screenshots gerados pelo Cypress
			archiveArtifacts artifacts: "${PROJECT_DIR}/cypress/videos/**, ${PROJECT_DIR}/cypress/screenshots/**", allowEmptyArchive: true
		}
	}
}