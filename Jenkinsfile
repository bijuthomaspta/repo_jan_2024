@Library ("my_library") _
pipeline {
   agent none
  stages {
     stage ( 'Back-end') {
        agent {
          docker { image 'node:16-alpine'}
            }
        steps {
           readme1()
        }
    } 
  }
}
