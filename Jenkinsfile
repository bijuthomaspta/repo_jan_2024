@Library ("my_library")pipeline {
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
