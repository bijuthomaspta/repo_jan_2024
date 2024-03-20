@Library ("mynewlb") _
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
        
    }
}
