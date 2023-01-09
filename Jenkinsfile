pipeline {
  agent any
  options {
         buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3')
}
  stages {
    stage('Checkout SCM') {
      steps {
      checkout([$class: 'GitSCM', branches: [[name: '*/vp-rem']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Phani808/vprofile-project.git']]])
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
                    sh 'docker build -t phani997/vprofile .'
                }
            }
        }
    stage('Deploying to container'){
      steps{
        script{
          sh 'docker-compose up -d'
        }
      }
    }
  }
} 
    
