# A Dockerfile to containerize the Flask app, making it easy to deploy across environments. It creates a Docker image that packages the app with all its dependencies.

# Why: Docker simplifies app deployment by providing a consistent runtime environment, regardless of where the app is deployed (locally, AWS, etc.).

# Key Steps:

# Build the Docker image.
# Run the Flask app inside a Docker container.
# Deploy the containerized app to an EC2 instance or an EKS (Kubernetes) cluster.

#  sets up the environment for the Flask app, ensuring it can run consistently across different environments.
# Use a slim version of Python as the base image

FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    python3-venv \
    && apt-get clean

# Create a virtual environment
RUN python3 -m venv /venv

# Set PATH for the virtual environment
ENV PATH="/venv/bin:$PATH"

# Copy requirements file
COPY ./app/requirements.txt /app/requirements.txt

# Install dependencies from requirements.txt, including numpy
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the application code
COPY ./app /app

# Command to run your application
CMD ["python", "app.py"]

##dst
