pipeline {
    agent any

    stage('Build Docker Image') {
    steps {
        sh 'docker build -t $DOCKER_IMAGE .'
    }
}
environment {
    DOCKER_IMAGE = 'shanepringlegcu/cw2-server'
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



