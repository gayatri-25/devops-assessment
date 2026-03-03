# Stage 1: Builder
FROM python:3.11-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Final Image
FROM python:3.11-slim
WORKDIR /app

# Copy only installed dependencies from builder
COPY --from=builder /root/.local /root/.local
COPY ./app ./app

# Ensure scripts in .local/bin are usable
ENV PATH=/root/.local/bin:$PATH

# Security: Run as non-root user
RUN useradd -m devopsuser
USER devopsuser

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]