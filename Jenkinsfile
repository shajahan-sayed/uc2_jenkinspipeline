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
       try {
        // Build Docker image
        dockerImage = docker.build("shajahans2/uc2_jenkinspipeline:${env.BUILD_NUMBER}")
        
        // Push Docker image
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials-id') {
          echo "Pushing Docker image ${dockerImage.imageName}..."
          dockerImage.push()
          dockerImage.push('latest')
        }
        echo "Docker push successful!"
      } catch (err) {
        echo "Docker push failed: ${err}"
        currentBuild.result = 'FAILURE'
        error("Stopping pipeline due to Docker push failure.")
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

   
        
   
      
