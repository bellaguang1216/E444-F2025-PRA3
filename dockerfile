# syntax=docker/dockerfile:1
FROM python:3.12-slim

WORKDIR /app

# (optional) system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app
COPY . .

# Optional hint for local dev; Render will inject PORT at runtime
EXPOSE 8000

# Use shell form so $PORT is expanded; default to 8000 if not set
CMD ["sh", "-c", "gunicorn project.app:app --bind 0.0.0.0:${PORT:-8000}"]
