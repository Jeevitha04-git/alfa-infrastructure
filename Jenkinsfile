pipeline {
    agent any
 
    options {
        timestamps()
    }
 
    stages {
 
        stage('Checkout') {
            steps {
                echo 'Source code checkout stage'
                checkout scm
            }
        }
 
        stage('Build') {
            steps {
                echo 'Starting application build'
                sh 'echo "Application build successful"'
            }
        }
 
        stage('Test') {
            steps {
                echo 'Executing test stage'
                sh 'echo "Test execution successful"'
            }
        }
 
        stage('Package') {
            steps {
                echo 'Packaging application'
                sh 'echo "Package creation successful"'
            }
        }
    }
 
    post {
        success {
            echo 'CI BUILD SUCCESSFUL'
        }
 
        failure {
            echo 'CI BUILD FAILED'
        }
    }
}
