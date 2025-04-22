pipeline {
  agent any

  environment {
    SONARQUBE_SERVER = 'sonarqube'
    VENV = "${WORKSPACE}/venv"
  }

  stages {

    stage('Check Python Version') {
      steps {
        sh 'python3 --version'
      }
    }

    stage('Clonar repositorio') {
      steps {
        git branch: 'main', url: 'https://github.com/zirot618/taller-jenkins.git'
      }
    }

    stage('Instalar dependencias') {
      steps {
        sh """
          python3 -m venv $VENV
          source $VENV/bin/activate
          pip install --upgrade pip
          pip install -r requirements.txt
        """
      }
    }

    stage('Pruebas unitarias') {
      steps {
        sh """
          source $VENV/bin/activate
          pytest --maxfail=1 --disable-warnings --quiet
        """
      }
    }

    stage('Construir imagen Docker') {
      steps {
        script {
          dockerImage = docker.build("javierlopez618/clase10-tallercd")
        }
      }
    }

    stage('Login to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
        }
      }
    }

    stage('Push to DockerHub') {
      steps {
        script {
          docker.image('javierlopez618/clase10-tallercd').push()
        }
      }
    }

    stage('Lint') {
      steps {
        sh """
          source $VENV/bin/activate
          pip install pylint
          pylint src --output-format=json > pylint-report.json || true
        """
      }
    }

    // Si estás usando SonarQube en Linux también, descomenta y ajusta esto:
    // stage('Análisis SonarQube') {
    //   steps {
    //     withSonarQubeEnv("${SONARQUBE_SERVER}") {
    //       withCredentials([string(credentialsId: 'sonarqube_auth_token', variable: 'SONAR_TOKEN')]) {
    //         sh """
    //           sonar-scanner \
    //             -Dsonar.projectKey=my-python-app \
    //             -Dsonar.sources=src \
    //             -Dsonar.host.url=http://sonarqube:9000 \
    //             -Dsonar.token=$SONAR_TOKEN \
    //             -Dsonar.python.coverage.reportPaths=coverage.xml \
    //             -Dsonar.python.pylint.reportPaths=pylint-report.json
    //         """
    //       }
    //     }
    //   }
    // }

  }
}
