pipeline {
	agent any

	stages {
		stage('Dependencies') {
			steps {
				sh 'npm i'
			}
		}
		stage(''){
			sh 'npm run test:ci'
		}
	}
}