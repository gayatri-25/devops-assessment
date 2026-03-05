# README.md

# **FastAPI Microservice: CI/CD & Cloud Deployment**

This project demonstrates a production-ready DevOps workflow for a Python FastAPI microservice. It features a modular code structure, multi-stage Docker builds, and a fully automated CI/CD pipeline deploying to AWS ECS Fargate.

## **🏗 Architecture Overview**

The system follows a modern "GitOps" flow:

* **Local Development**: Python 3.11 with FastAPI.

* **Continuous Integration**: GitHub Actions runs linting and unit tests on every Pull Request.

* **Continuous Deployment**: On merge to main, a Docker image is built for linux/amd64, pushed to Amazon ECR, and the AWS ECS Fargate service is updated.


## 🚀 Local Development Workflow

### Prerequisites

Docker Desktop (with WSL2 backend for Windows)

Python 3.11+

### Steps

#### Clone and Setup:

* Bash
* git clone <your-repo-url>
* cd Project


#### Build the Container:

* Bash
* docker build -t fastapi-app .

#### Run the Container:

* Bash
* docker run -p 8000:8000 --name my-running-app fastapi-app

#### Access the API:

Navigate to http://localhost:8000 in your browser.

## **🧪 Unit Testing**

Testing is integrated into the CI pipeline. To run tests locally:

* Bash
* pip install -r requirements.txt
* pytest


The tests verify the root endpoint and the /health check required for AWS Target Group health monitoring.

## 🛠 CI/CD Pipeline Explanation

### A. Pull Request Workflow (pr-validation.yml)

Triggered on PRs targeting the main branch.

Performs code quality checks and runs pytest.

Executes a "Dry Run" Docker build to ensure the Dockerfile is valid before merging.

### B. Deployment Workflow (deploy.yml)

Triggered on merges to main.

Authenticates with AWS using IAM OIDC/Secrets.

#### Architecture: 
Builds using --platform linux/amd64 to ensure compatibility with Fargate X86_64 nodes.

#### Deployment: 
Updates the ECS Task Definition with the new image tag and performs a rolling update.

## ☁️ Deployment Instructions (AWS)

Registry: Amazon ECR.

Compute: AWS ECS Fargate (Serverless).

Networking: Service is hosted in a Public Subnet.

Security Group: Inbound TCP traffic allowed on Port 8000 from 0.0.0.0/0.