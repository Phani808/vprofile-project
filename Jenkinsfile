pipeline {
    agent any
           options {
         buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3')
}

    stages {
            stage('Repo cloning') {
                  steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/ci-jenkins']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Phani808/vprofile-project.git']]])
   
      }
    } 
        stage('maven build') {
        steps{    
            sh 'mvn clean package'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                   sh 'cd /var/lib/jenkins/workspace/v_profile/vprofile-project'
                    
                }
            }
        }
 } 
}    
    
