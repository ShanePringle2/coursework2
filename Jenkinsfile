pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'shanepringlegcu/cw2-server'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/ShanePringle2/coursework2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and assign it to the dockerImage variable
                    dockerImage = docker.build("${DOCKER_IMAGE_NAME}")
                }
            }
        }

        stage('Test Docker Container') {
            steps {
                script {
                    // Remove any existing container with the same name
                    if (sh(script: 'docker ps -aq -f name=test-container', returnStdout: true).trim()) {
                        sh 'docker rm -f test-container'
                    }
                    // Run a container from the built image
                    sh 'docker run -d --name test-container ${DOCKER_IMAGE_NAME}'
                    // Execute a command inside the container to verify it is running
                    sh 'docker exec test-container echo "Container is running successfully!"'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo 'Deploying to Kubernetes...'
                // Add your Kubernetes deployment commands here
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
    }
}
