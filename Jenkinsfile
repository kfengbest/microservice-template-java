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
                sh "mkdir artifect"
                sh "cp Dockerfile artifect"
                sh "cp Dockerrun.aws.json artifect"
                sh "cp ./target/*.war artifect"
                sh "zip -r artifect.zip artifect/*"
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
