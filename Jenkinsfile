pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Run Cypress inside Docker') {
      steps {
		  sh '''
			docker run --rm \
			  -v "/var/jenkins_home/workspace/Cypress Tests:/e2e" \
			  -w /e2e \
			  cypress/included:13.12.0 \
			  npx cypress run --browser chrome --headless
			'''
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'cypress/videos/**, cypress/screenshots/**', allowEmptyArchive: true
    }
  }
}