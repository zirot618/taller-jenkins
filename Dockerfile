FROM python:3.12-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src ./src
COPY mockoon.json .
ENV SERVER_URL=http://mockoon:4000/user_type

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
