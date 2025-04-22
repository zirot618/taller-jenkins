"""Aca modifique lo del jenkins añadiendo esto : 
Checkout del código, instalación de las dependencias, ejecución de las pruebas unitarias, construcción de la imagen Docker, login a DockerHub y el push de la imagen a DockerHub"""

pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'zirot618/taller-jenkins'
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials' // ID de las credenciales en Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/zirot618/taller-jenkins.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'pytest'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKERHUB_CREDENTIALS}") {
                        echo 'Autenticado correctamente en DockerHub'
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKERHUB_CREDENTIALS}") {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        failure {
            echo 'El pipeline falló. Verifica los logs.'
        }
        success {
            echo 'Pipeline ejecutado correctamente. Imagen publicada en DockerHub.'
        }
    }
}
