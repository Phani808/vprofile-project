pipeline {
  agentany
  options {
         buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3')
}
  stages {
    stage('Checkout SCM') {
      steps {
      checkout([$class: 'GitSCM', branches: [[name: '*/vp-rem']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Phani808/vprofile-project.git']]])
    }
    } 
  }
} 
    
