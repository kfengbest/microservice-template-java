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
                sh "zip -r artifect.zip Dockerfile Dockerrun.aws.json ./target/*.war"
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
