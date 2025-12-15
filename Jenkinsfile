pipeline {
  agent {
    docker {
          image 'maven:3.8.6-openjdk-11'
            args '-v $HOME/.m2:/root/.m2' // cache Maven dependencies
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
        
    stage ('DOCKER BUILD IMAGE') {
      steps {
          script {
                    dockerImage = docker.build("shajahans2/uc2_jenkinspipeline:${env.BUILD_NUMBER}")
          }
      }
    }
    stage ('DOCKER PUSH IMAGE') {
      steps {
        script {
              docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials-id') {
                        dockerImage.push()
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

   
        
   
      
