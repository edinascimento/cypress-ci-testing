pipeline {
	agent any

	stages {
		stage('Checkout') {
			steps {
				checkout scm
			}
		}

		stage('Dependencies') {
			ssh 'npm i'
		}

		stage('ci') {
			ssh 'npm run test:ci'
		}

	}

	post {
		always {
			archiveArtifacts artifacts: "cypress/videos/**, cypress/screenshots/**", allowEmptyArchive: true
		}
	}
}