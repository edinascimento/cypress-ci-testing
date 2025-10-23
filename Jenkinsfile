pipeline {
	agent any

	environment {
		PROJECT_DIR = "cypress-ci-testing"
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
				// Roda Cypress dentro de um container Docker
				sh '''
				docker run --rm \
				  --entrypoint sh \
				  -v "$PWD/${PROJECT_DIR}:/e2e" \
				  -w /e2e \
				  cypress/included:15.5.0 \
				  -c "npm ci && npx cypress run --browser chrome --headless"
				'''
			}
		}
	}

	post {
		always {
			// Salva vídeos e screenshots
			archiveArtifacts artifacts: "${PROJECT_DIR}/cypress/videos/**, ${PROJECT_DIR}/cypress/screenshots/**", allowEmptyArchive: true
		}
	}
}