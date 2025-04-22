# Imagen base ligera de Python 3.12
FROM python:3.12-slim

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar archivo de dependencias
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente
COPY src ./src

# Copiar archivo de configuración mockoon
COPY mockoon.json .

# Variable de entorno
ENV SERVER_URL=http://mockoon:4000/user_type

# Comando para ejecutar la aplicación FastAPI con Uvicorn
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]

