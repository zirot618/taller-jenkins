pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'zirot618/taller-jenkins'
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/zirot618/taller-jenkins.git'
            }
        }

        stage('Instalar dependencias') {
            steps {
                bat '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Unit Tests') {
            steps {
                bat 'pytest --maxfail=1 --disable-warnings'
            }
        }
    }

    post {
        failure {
            echo '❌ El pipeline falló. Verifica los logs.'
        }
        success {
            echo '✅ Pipeline ejecutado correctamente.'
        }
    }
}
