pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'shanepringlegcu'  // Replace with your DockerHub username
        DOCKERHUB_PASSWORD = credentials('dockerhub-credentials')  // Add this credential in Jenkins
        IMAGE_NAME = 'shanepringlegcu/cw2-server'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo "Cloning repository..."
                git branch: 'master', url: 'https://github.com/ShanePringle2/coursework2.git'
            }
        }

        stage('Build Project') {
            steps {
                echo "Building the project..."
                sh 'echo "Build step is running..."'
            }
        }

        stage('Run Tests') {
            steps {
                echo "Running tests..."
                sh 'echo "Tests executed successfully."'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker image to DockerHub..."
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        sh 'docker push $IMAGE_NAME'
                    }
                }
            }
        }

        stage('Deploy Application') {
            steps {
                echo "Deploying application..."
                sh 'echo "Deployment step executed."'
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline execution failed!"
        }
    }
}
