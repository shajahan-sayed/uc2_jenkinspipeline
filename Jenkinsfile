pipeline {
  agent {
     docker {
      image 'abhishekf5/maven-abhishek-docker-agent:v1'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock' // mount Docker socket to access the host's Docker daemon
    }
  }
  stages {
    stage ('git checkout') {
      steps{
           sh 'echo passed'
        //git branch: 'main', url: 'https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git (here i need to paste my github url'
      }
    }
    stage ('build') {
      steps {
       sh 'mvn clean package -DskipTests'
      }
    }
   stage('SonarQube Analysis') {
            environment {
                SONAR_TOKEN = credentials('sonarqube-token')
            }
            steps {
                sh """
                mvn sonar:sonar \
                -Dsonar.projectKey=uc2_jenkinspipeline \
                -Dsonar.host.url=http://3.26.17.105:9000 \
                -Dsonar.login=${SONAR_TOKEN} 
                """
            }
   }
        
    stage('Docker Build & Push') {
      steps {
        script {
          // Docker build uses the JAR already created in target/
          dockerImage = docker.build("shajahans2/uc2_jenkinspipeline:${env.BUILD_NUMBER}")
          docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials-id') {
            dockerImage.push()
            dockerImage.push('latest')
          }
        }
      }
    }
        
  }
 
post {
        success {
            echo 'Build and push successful!'
        }
        failure {
            echo 'Build failed.'
        }
    } 
}

   
        
   
      
