pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/your-image-name'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/ShanePringle2/coursework2'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Test Docker Container') {
            steps {
                sh '''
                docker run -d --name test-container $DOCKER_IMAGE
                docker exec test-container echo "Container is running successfully!"
                docker stop test-container
                docker rm test-container
                '''
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
