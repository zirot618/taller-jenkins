pipeline {
    agent {
    }

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

        """stage('Install Dependencies') {
            steps {
                sh 'pip install --upgrade pip && pip install -r requirements.txt'
            }
        }"""

        stage('Instalar dependencias') {
            steps {
                sh """
                "C:\\Users\\USUARIO\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m venv %VENV%
                call %VENV%\\Scripts\\activate.bat
                "%VENV%\\Scripts\\pip.exe" install --upgrade pip
                "%VENV%\\Scripts\\pip.exe" install -r requirements.txt
            """
            }
        }

        stage('Code Style (pre-commit)') {
            steps {
                sh '''
                    pip install pre-commit
                    pre-commit run --all-files
                '''
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'pytest --maxfail=1 --disable-warnings'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Login to DockerHub and Push') {
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
            echo '❌ El pipeline falló. Verifica los logs.'
        }
        success {
            echo '✅ Pipeline ejecutado correctamente. Imagen publicada en DockerHub.'
        }
    }
}
