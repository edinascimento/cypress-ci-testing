pipeline {
	agent any

	tools {nodejs "nodejs24"}

	stages {
		stage('Dependencies') {
			steps {
				sh 'npm i'
			}
		}
	}
}