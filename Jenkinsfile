pipeline {
    agent any

    environment {
        DB_HOST = 'mysqldb'
        DB_USER = 'root'
        DB_PASSWORD = '1'
        DOCKER_IMAGE = 'mywp'
        DOCKER_TAG = "${GIT_BRANCH.tokenize('/').pop()}-${GIT_COMMIT.substring(0,7)}"
        DOCKER_CREDENTIALS = credentials('docker_credentials')
        DOCKER_HUB = 'phungducmanh666'
        DOCKER_CONTAINER_NAME = "worldpress"
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
                    // build image ne
                    sh "docker build -t ${DOCKER_HUB}/${env.DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('push image') {
            steps {
                script {
                    // login -> push -> remove local image
                    echo 'Push image...'
                    sh "echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin \
                    && docker push ${DOCKER_HUB}/${env.DOCKER_IMAGE}:${DOCKER_TAG} \
                    && docker rmi  ${DOCKER_HUB}/${env.DOCKER_IMAGE}:${DOCKER_TAG}\
                    "
                }
            }
        }

        stage('ssh to deploy server') {
            steps {
                script {
                    echo 'Deploying...'
                    def cmd = "#!/bin/bash \n" +
                    "docker rm -f ${DOCKER_CONTAINER_NAME} \n" + 
                    "docker pull ${DOCKER_HUB}/${env.DOCKER_IMAGE}:${DOCKER_TAG} \n" + 
                    "docker run --name=${DOCKER_CONTAINER_NAME} --network mynet -dp 8080:80 -e WORDPRESS_DB_HOST=mysqldb -e WORDPRESS_DB_NAME=wordpress -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=1 ${DOCKER_HUB}/${env.DOCKER_IMAGE}:${DOCKER_TAG} \n"

                    sshagent(credentials:['jenkins_ssh_key']){
                        sh """
                            ssh -o stricthostkeychecking=no -i jenkins_ssh_key sa@192.168.235.130 "echo \\\"${cmd}\\\" > deploy.sh && chmod +x deploy.sh && ./deploy.sh"
                        """
                    }
                }
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
