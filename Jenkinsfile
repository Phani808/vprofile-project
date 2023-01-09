pipeline {
    agent any
           options {
         buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3')
}

    stages {
            stage('Repo cloning') {
                  steps {
                  git 'https://github.com/Phani808/projectk.git'
            } 
            
        }
        stage('maven build') {
                  steps{    
                   sh 'mvn install'
            }
        }
    }
}  
