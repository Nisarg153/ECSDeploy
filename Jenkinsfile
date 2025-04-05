pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'githubcreds', url: 'https://github.com/Nisarg153/DockerDeploy']])
            }
        }
        stage('maven build package'){
            steps {
                sh 'mvn clean package'
            }
        }
        stage('docker push'){
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'DockerCreds', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USER')]) {
                        sh ''' echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USER" --password-stdin '''
                        sh 'docker build -t nisarg153/dockerpipeline2:latest .'
                        sh 'docker push nisarg153/dockerpipeline2:latest'
                    }
                }
            }
        }
        stage('Configuring Docker pull pipeline'){
            steps{
                build 'DockerPullPipeline'
            }
        }
    }
}
