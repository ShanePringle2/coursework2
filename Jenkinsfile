pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'shanepringlegcu/cw2-server'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/ShanePringle2/coursework2'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Test Docker Container') {
    steps {
        script {
          
            sh '''
                if [ $(docker ps -aq -f name=test-container) ]; then
                    docker rm -f test-container
                fi
            '''
    
            sh '''
                docker run -d --name test-container shanepringlegcu/cw2-server
                docker exec test-container echo "Container is running successfully!"
            '''
        }
    }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl set image deployment/your-deployment-name your-container-name=$DOCKER_IMAGE --record
                kubectl rollout status deployment/your-deployment-name
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
    }
}
