pipeline {
  agentany
  stages {
    stage('Checkout SCM') {
      checkout([$class: 'GitSCM', branches: [[name: '*/vp-rem']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Phani808/vprofile-project.git']]])
    }
  }
} 
    
