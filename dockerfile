# syntax=docker/dockerfile:1
FROM python:3.12-slim

WORKDIR /app

# Install system deps (optional)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential && rm -rf /var/lib/apt/lists/*

# Copy and install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app
COPY . .

# Render provides PORT
ENV PORT=8000
CMD ["gunicorn", "project.app:app", "--bind", "0.0.0.0:${PORT}"]
