pipeline {
    agent any

    environment {
        DB_HOST = 'mysqldb'
        DB_USER = 'root'
        DB_PASSWORD = '1'
        DOCKER_IMAGE = 'phungducmanh666/mywp'
        DOCKER_TAG = "${GIT_BRANCH.tokenize('/').pop()}-${GIT_COMMIT.substring(0,7)}"
    }

    stages {

        stage('print env') {
            steps {
                script{
                    echo "${env.DOCKER_TAG}"
                }
            }
        }

        stage('build image') {
            steps {
                script{
                    echo 'Building...'
                    // build image
                    sh "docker build -t ${env.DOCKER_IMAGE}:${DOCKER_TAG} ."

                }
            }
        }

        stage('push image') {
            steps {
                echo 'Testing...'
                // Thực hiện lệnh test, ví dụ: chạy unit tests
            }
        }

        stage('ssh to deploy server') {
            steps {
                echo 'Deploying...'
                // Thực hiện lệnh deploy, ví dụ: deploy ứng dụng
            }
        }
    }

    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
    }
}
