pipeline {
    agent any
    
    environment {
        ECR_IMG = 'my-java-app'
        version = 'latest'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git credentialsId: 'githubcreds', url: 'https://github.com/Nisarg153/ECSDeploy.git'
            }
        }
        stage('maven Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Docker Build'){
            steps{
                sh 'docker build -t ${ECR_IMG}:${version} .'
            }
        }
        stage('AWS ECR login') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    sh '''
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 029197504624.dkr.ecr.us-east-1.amazonaws.com
                    '''
                }
            }
        }
        stage('docker tag and push the image to ECR'){
            steps{
                    sh 'docker tag my-java-app:latest 029197504624.dkr.ecr.us-east-1.amazonaws.com/my-java-app:latest'
                    sh 'docker push 029197504624.dkr.ecr.us-east-1.amazonaws.com/my-java-app:latest'
            }
        }
        stage('Configuring ECRPUll Pipeline 0204'){
            steps{
                build 'ECRPullpipeline0204'
            }
        }
    }
}
