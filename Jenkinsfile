pipeline {
	agent {
		docker {
			image 'cypress/included:15.5.0'
			args '-u 0'
		}
	}

	stages {
		stage('Install Dependencies') {
			steps {
				sh 'npm ci'
			}
		}

		stage('Run Cypress Tests') {
			steps {
				sh 'npx cypress run --reporter mochawesome --reporter-options "reportDir=cypress/results,overwrite=false,html=false,json=true"'
			}
		}
	}

	post {
		always {
			echo 'Pipeline finalizado.'
			archiveArtifacts artifacts: "cypress/videos/**/*.mp4, cypress/screenshots/**/*.png", allowEmptyArchive: true
		}
		success {
			script {
				sh 'npm install -g mochawesome-merge mochawesome-report-generator'
				sh 'mochawesome-merge cypress/results/*.json > mochawesome-report.json'
				sh 'marge mochawesome-report.json'
			}	
			publishHTML([
				allowMissing: false,
				alwaysLinkToLastBuild: true,
				keepAll: true,
				reportDir: 'mochawesome-report',
				reportFiles: 'index.html',
				reportName: 'Mochawesome Report'
			])
			echo 'Testes concluídos com sucesso.'
		}
		failure {
			echo 'Testes falharam.'
		}
	}
}
