pipeline {
    agent any
           options {
         buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3')
}

    stages {
            stage('Repo cloning') {
                  steps {
                  git 'https://github.com/Phani808/vprofile-project.git'
            } 
            
        }
        stage('maven build') {
                  steps{    
                   sh 'mvn install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'cp -r target /dockerfiles/app'
                    sh 'cd dockerfiles'
                    sh 'cd app'
                    sh 'docker build -t phani997/vprofileapp .'
                }
            }
        }
    }
}  
