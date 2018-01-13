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
                sh "git archive -v -o artifect.zip --format=zip HEAD"
            }
        }
        stage('Upload to S3') {
            steps {
                sh "ls"
                // withAWS(region:"us-east-1",credentials:"global_usnp_aws_r") {
                //     s3Upload(file:"artifect.zip", bucket:"s3-fusion-service-prd",path:"artifect.zip")
                // }
            }
        }
    }
}
