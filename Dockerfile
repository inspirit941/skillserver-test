# Use an official Python runtime as a parent image
FROM --platform=linux/amd64 python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install --upgrade pip
RUN pip install poetry

# Copy only requirements to cache them in docker layer
COPY pyproject.toml /app/

# Project initialization:
# Note: `--no-dev` option if you do not want development dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Copying the rest of the app
COPY . /app

# Command to run on container start
CMD ["python3", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "1",  "--forwarded-allow-ips='*'", "--proxy-headers" ]
