pipeline {
    agent {
        docker { 
            image 'docker:latest' 
        }
    }

    environment {
        DOCKERHUB_USERNAME = 'shanepringlegcu' // Replace with your DockerHub username
        DOCKERHUB_PASSWORD = credentials('dockerhub-credentials') // Jenkins credential ID
        IMAGE_NAME = 'shanepringlegcu/cw2-server'
        DOCKER_CONFIG = "${env.WORKSPACE}/.docker" // Set a writable config directory
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/ShanePringle2/coursework2.git'
            }
        }

        stage('Build') {
            steps {
                sh 'echo "Building the project..."'
            }
        }

        stage('Test') {
            steps {
                sh 'echo "Running tests..."'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    mkdir -p $DOCKER_CONFIG
                    docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        sh 'docker push $IMAGE_NAME'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'echo "Deploying application..."'
            }
        }
    }
}
