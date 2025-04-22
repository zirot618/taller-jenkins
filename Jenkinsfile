pipeline {
  agent any

  environment {
    SONARQUBE_SERVER = 'sonarqube'
    SONAR_SCANNER_HOME = 'C:\\sonarqube\\sonarqube-25.4.0.105899\\bin\\windows-x86-64'  // Cambia esto a la ruta real en tu Windows
    VENV = "${WORKSPACE}\\venv"
  }

  stages {
    stage('Check Python Version') {
      steps {
        sh '"C:\\Users\\USUARIO\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" --version'
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
          "C:\\Users\\USUARIO\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m venv %VENV%
          call %VENV%\\Scripts\\activate.bat
          "%VENV%\\Scripts\\pip.exe" install --upgrade pip
          "%VENV%\\Scripts\\pip.exe" install -r requirements.txt
        """
      }
    }

    stage('Pruebas unitarias') {
      steps {
        sh """
          call %VENV%\\Scripts\\activate.bat
          "%VENV%\\Scripts\\pytest.exe" --maxfail=1 --disable-warnings --quiet
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
          sh """
            echo %DOCKER_PASS% | docker login -u %DOCKER_USER% -p %DOCKER_PASS%
          """
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
          call %VENV%\\Scripts\\activate.bat
          pip install pylint
          pylint src --output-format=json > pylint-report.json || exit 0
        """
      }
    }

    // stage('Análisis SonarQube') {
    //   steps {
    //     withSonarQubeEnv("${SONARQUBE_SERVER}") {
    //       withCredentials([string(credentialsId: 'sonarqube_auth_token', variable: 'SONAR_TOKEN')]) {
    //         bat """
    //           "${SONAR_SCANNER_HOME}\\StartSonar.bat" ^
    //             -Dsonar.projectKey=my-python-app ^
    //             -Dsonar.sources=src ^
    //             -Dsonar.host.url=http://sonarqube:9000 ^
    //             -Dsonar.token=%SONAR_TOKEN% ^
    //             -Dsonar.python.coverage.reportPaths=coverage.xml ^
    //             -Dsonar.python.pylint.reportPaths=pylint-report.json
    //         """
    //       }
    //     }
    //   }
    // }
  }
}