pipeline {
	agent any

	stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}

		stage('Build Cypress Image') {
			steps {
				sh 'docker build -f Dockerfile -t cypress-tests:latest .'
			}
		}

		stage('Debug Container') {
			steps {
				sh '''
                PWD=$(pwd)
                echo "Current directory: $PWD"
                docker run --rm -v $PWD:/e2e -w /e2e cypress-tests:latest ls -la /e2e
             '''
			}
		}

		stage('Run Cypress Tests') {
			steps {
				sh '''
                PWD=$(pwd)
                docker run --rm -v $PWD:/e2e -w /e2e cypress-tests:latest npx cypress run
             '''
			}
		}
	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/videos/**/*.mp4, cypress/screenshots/**/*.png", allowEmptyArchive: true
		}
	}
}