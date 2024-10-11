# A Dockerfile to containerize the Flask app, making it easy to deploy across environments. It creates a Docker image that packages the app with all its dependencies.

# Why: Docker simplifies app deployment by providing a consistent runtime environment, regardless of where the app is deployed (locally, AWS, etc.).

# Key Steps:

# Build the Docker image.
# Run the Flask app inside a Docker container.
# Deploy the containerized app to an EC2 instance or an EKS (Kubernetes) cluster.

#  sets up the environment for the Flask app, ensuring it can run consistently across different environments.

FROM python:3.8-slim
COPY ./app /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
