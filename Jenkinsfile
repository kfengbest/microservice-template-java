pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh "mvn clean build"
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
                sh "mvn package"
                sh "git archive -v -o artifect.zip --format=zip HEAD"
            }
        }
        stage('Upload to S3') {
            steps {
                // withAWS(region:"us-east-1",credentials:"global_usnp_aws_r") {
                //     s3Upload(file:"artifect.zip", bucket:"s3-fusion-service-prd",path:"artifect.zip")
                // }
            }
        }
    }
}
