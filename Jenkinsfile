pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'zirot618/taller-jenkins'
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials'
    }

    stages {
        stage('Instalar dependencias') {
            steps {
                bat '''
                    python -m venv venv
                    call venv\\Scripts\\activate
                    python -m pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Unit Tests') {
            steps {
                bat '''
                    call venv\\Scripts\\activate
                    pytest --maxfail=1 --disable-warnings
                '''
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
