# Imagen base ligera de Python 3.12
FROM python:3.12-slim

FROM jenkins/jenkins:lts

USER root

# Instala Python 3 y pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    python3 -m pip install --upgrade pip

# Opcional: instala git si tu Jenkinsfile lo necesita
RUN apt-get install -y git

# Vuelve al usuario Jenkins
USER jenkins
