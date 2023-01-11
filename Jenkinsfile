pipeline {
  agent any
  options {
         buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '1')
}
  stages {
    stage('Checkout SCM') {
      steps {
      checkout([$class: 'GitSCM', branches: [[name: '*/vp-rem']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Phani808/vprofile-project.git']]])
    }
    }
    stage('Sonar Quality status'){
    steps{
   
        withSonarQubeEnv('mysonar') {
    sh 'mvn clean package sonar:sonar'
      
      }
    } 
}
    stage('BUILD'){
            steps {
                sh 'mvn clean install -DskipTests'
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }

	stage('UNIT TEST'){
            steps {
                sh 'mvn test'
            }
        }

	stage('INTEGRATION TEST'){
            steps {
                sh 'mvn verify -DskipUnitTests'
            }
        }
		
        stage ('CODE ANALYSIS WITH CHECKSTYLE'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
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
    
