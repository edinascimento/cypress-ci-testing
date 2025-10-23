pipeline {
	agent any

	stages {
		stage('Cleanup') {
			steps {
				sh '''
                docker rm -f cypress-runner || true
                docker rmi -f cypress-tests:latest || true
             '''
			}
		}

		stage('Checkout') {
			steps {
				git branch: 'main', url: 'https://github.com/edinascimento/cypress-ci-testing.git'
			}
		}

		stage('Build Docker Image') {
			steps {
				sh 'docker build -f Dockerfile -t cypress-tests:latest .'
			}
		}

		stage('Run Cypress Tests') {
			steps {
				sh '''
                echo "=== Starting Cypress Tests ==="
                docker run --name cypress-runner cypress-tests:latest

                echo "=== Checking container exit code ==="
                docker inspect cypress-runner --format='{{.State.ExitCode}}'

                echo "=== Container logs ==="
                docker logs cypress-runner || true

                echo "=== Listing /e2e/cypress contents ==="
                docker run --rm -v cypress-runner:/data busybox ls -la /data/cypress/ || true

                mkdir -p cypress/reports
                docker cp cypress-runner:/e2e/cypress/reports/. ./cypress/reports/ || true
                docker cp cypress-runner:/e2e/cypress/videos/. ./cypress/videos/ || true
                docker cp cypress-runner:/e2e/cypress/screenshots/. ./cypress/screenshots/ || true

                echo "=== Local directory contents ==="
                ls -laR cypress/

                docker rm cypress-runner || true
             '''
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/**/*", allowEmptyArchive: true
			publishHTML([
				reportDir: 'cypress/reports',
				reportFiles: 'mochawesome.html',
				reportName: 'Cypress Test Report',
				allowMissing: true,
				alwaysLinkToLastBuild: true,
				keepAll: true
			])
		}
	}
}