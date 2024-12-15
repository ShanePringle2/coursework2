pipeline {
    agent any

    stages {
        stage('Clone') {
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

        stage('Deploy') {
            steps {
                sh 'echo "Deploying application..."'
            }
        }
    }
}

pipeline {
    agent {
        docker { image 'docker:latest' }
    }

    environment {
        DOCKERHUB_USERNAME = 'shanepringlegcu' // Replace with your DockerHub username
        DOCKERHUB_PASSWORD = credentials('Runescape#1') // Add this credential in Jenkins
        IMAGE_NAME = 'shanepringlegcu/cw2-server:1.0'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/ShanePringle2/coursework2'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
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
    }
}

