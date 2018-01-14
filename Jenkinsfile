pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh "mvn clean package"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh "mvn test"
            }
        }
        stage('Packaging'){
            steps {
                sh "rm -rf artifect.zip"
                sh "cp ./target/*.war ."
                sh "zip -r artifect.zip Dockerfile Dockerrun.aws.json ./*.war"
            }
        }
        stage('Docker Build') {
            steps {
                sh "docker build -t kfengbest/mst-java:latest ."
            }
        }
        stage('Docker Push') {
            agent any
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                sh 'docker push kfengbest/mst-java:latest'
                }
            }                
        stage('Upload to S3') {
            steps {
                sh "ls"
                 withAWS(region:"us-east-1",credentials:"global_usnp_aws_r") {
                     s3Upload(file:"artifect.zip", bucket:"s3-java-prd",path:"artifect.zip")
                 }
            }
        }
    }
}
