pipeline {
	agent any

	tools {nodejs "nodejs24"}

	stages {
		stage("Dependencies") {
			steps {
				sh 'npm i'
			}
		}
		stage("e2e Tests") {
			steps {
				sh 'npm run cy:ci'
			}
		}
	}
}