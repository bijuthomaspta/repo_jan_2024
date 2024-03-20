pipeline {
    agent none
        
    stages {
        stage('Test') {
          agent {
              docker { image 'node:20.11.1-alpine3.19' }
          }
          steps {
                sh 'node --version'
            }
        }
        stage('Back-End') {
          agent {
              docker { image 'maven:3.9.6-ibmjava-8' }
          }
          steps {
                sh 'mvn --version'
            }
        }
        stage('Database') {
          agent {
              docker { image 'mysql:latest' }
          }
          steps {
                sh 'mysql -V'
            }
        }
    }
}
