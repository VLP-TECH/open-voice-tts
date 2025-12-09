FROM python:3.10-slim

# Dependencias mínimas del sistema: git y libsndfile (para audio)
RUN apt-get update && apt-get install -y git libsndfile1 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 1) PyTorch + torchaudio SOLO CPU (sin CUDA, mucho más ligero que antes)
RUN pip install --no-cache-dir \
    --index-url https://download.pytorch.org/whl/cpu \
    "torch==2.3.1+cpu" "torchaudio==2.3.1+cpu"

# 2) Resto de dependencias Python
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# 3) Clonar OpenVoice
RUN git clone https://github.com/myshell-ai/OpenVoice.git /app/OpenVoice

# 4) Tu API + voz de referencia
COPY app.py /app/
COPY reference /app/reference

EXPOSE 8002

CMD ["python", "app.py"]
