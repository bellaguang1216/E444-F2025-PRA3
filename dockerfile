# syntax=docker/dockerfile:1
FROM python:3.12-slim

# Set working directory to /app
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy everything into the container
COPY . .

# Move into the actual app folder so Python can see `project/`
WORKDIR /app/flaskr-tdd
ENV PYTHONPATH=/app/flaskr-tdd

# Run with gunicorn; expand $PORT at runtime
CMD ["sh", "-c", "gunicorn project.app:app --bind 0.0.0.0:${PORT:-8000}"]
