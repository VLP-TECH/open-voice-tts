FROM python:3.10-slim

RUN apt-get update && apt-get install -y git ffmpeg && apt-get clean

WORKDIR /app

# Clonar OpenVoice
RUN git clone https://github.com/myshell-ai/OpenVoice.git /app/OpenVoice

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py /app/
COPY reference /app/reference

EXPOSE 8002

CMD ["python", "app.py"]
