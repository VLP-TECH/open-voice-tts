FROM python:3.10-slim

RUN apt-get update && apt-get install -y git ffmpeg libsndfile1 && apt-get clean

WORKDIR /app

# 1) Instalar PyTorch + torchaudio SOLO CPU
RUN pip install --no-cache-dir \
    --index-url https://download.pytorch.org/whl/cpu \
    "torch==2.3.1+cpu" "torchaudio==2.3.1+cpu"

# 2) Resto de dependencias
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# 3) Clonar OpenVoice
RUN git clone https://github.com/myshell-ai/OpenVoice.git /app/OpenVoice

# 4) Copiar tu API y referencia
COPY app.py /app/
COPY reference /app/reference

EXPOSE 8002

CMD ["python", "app.py"]
