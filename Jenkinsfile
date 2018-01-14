pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh "mvn clean package"
                sh "pwd"
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
                sh "pwd"
                sh "ls"
            }
        }
        stage('Docker Build') {
            steps {
                sh "pwd"
                sh "ls -la"
                sh "docker build -t jk/v1 ."
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
