pipeline {
	agent any

	environment {
		PROJECT_DIR = "cypress-ci-testing"
		CYPRESS_IMAGE = "cypress/included:13.12.0"
	}

	stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}

		stage('Install with Docker') {
			steps {
				sh """
                cd \$PROJECT_DIR
                docker run --rm \\
                    -v "\$PWD:/e2e" \\
                    -w /e2e \\
                    \$CYPRESS_IMAGE \\
                    npm ci
             """
			}
		}

		stage('Run Cypress Tests') {
			steps {
				sh """
                cd \$PROJECT_DIR
                docker run --rm \\
                    -v "\$PWD:/e2e" \\
                    -w /e2e \\
                    \$CYPRESS_IMAGE \\
                    npx cypress run \\
                        --browser chrome \\
                        --headless \\
                        --record=false
             """
			}
		}

		stage('Report') {
			steps {
				sh """
                cd \$PROJECT_DIR
                echo "=== Vídeos ==="
                ls -lh cypress/videos/ 2>/dev/null || echo "Sem vídeos"
             """
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "\${PROJECT_DIR}/cypress/videos/**/*.mp4, \${PROJECT_DIR}/cypress/screenshots/**/*.png",
			allowEmptyArchive: true
		}
	}
}