pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'shanepringlegcu'
        DOCKERHUB_PASSWORD = credentials('dockerhub-credentials')
        IMAGE_NAME = 'shanepringlegcu/cw2-server'
    }

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

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
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
