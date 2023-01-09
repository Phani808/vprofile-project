pipeline {
    agent any
           options {
         buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3')
}

    stages {
            stage('Repo cloning') {
                  steps {
        sh 'git clone https://github.com/Phani808/vprofile-project.git'
   
      }
    } 
        stage('maven build') {
        steps{    
            sh 'mvn clean package'
            }
        }
 } 
}    
    
