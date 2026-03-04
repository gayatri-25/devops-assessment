# Stage 1: Builder
FROM python:3.11-slim as builder
WORKDIR /app
COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Stage 2: Final Image
FROM python:3.11-slim
WORKDIR /app


COPY --from=builder /install /usr/local
COPY ./app ./app


RUN useradd -m devopsuser && chown -R devopsuser:devopsuser /app
USER devopsuser

EXPOSE 8000


CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]