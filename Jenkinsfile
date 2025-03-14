pipeline {
  agent any
	 environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "34.125.18.214:8081"
        NEXUS_REPOSITORY = "vprofile-release"
	NEXUS_REPO_ID    = "vprofile-release"
        NEXUS_CREDENTIAL_ID = "nexuslogin"
        ARTVERSION = "${env.BUILD_ID}"
    }
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
	   stage("Publish to Nexus Repository Manager") {
            steps {
                script {
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version} ARTVERSION";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: ARTVERSION,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } 
		    else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
        }


    stage('Build docker image and push'){
            steps{
                script{
			withCredentials([string(credentialsId: 'nexus-pass', variable: 'nexus')]) {
			
				sh 'docker build -t 34.125.18.214:8083/vprofile .'
				sh 'docker login -u admin -p $nexus 34.125.18.214:8083'
				sh 'docker push 34.125.18.214:8083/vprofile'
   

			}
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
    
