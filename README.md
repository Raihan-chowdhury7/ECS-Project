# Containerised Threat Modelling Tool on AWS ECS Fargate

## Overview

This project deploys a containerised Threat Composer application on **AWS ECS Fargate** using **Terraform**, with the deployment fully automated through **GitHub Actions**.

The setup was created to **automate the deployment** of the threat modelling tool, eliminating the need to manually create AWS resources by leveraging **Infrastructure as Code (IaC)** using Terraform — just like it would be in a real-world production environment!

---

## Architecture Diagram

<p align="center">
  <img src="images/architecture diagram.png" style="width:700px"/>
</p>

---

## Features

- Fully automated infrastructure using **Terraform**
- Docker container pushed to **Amazon ECR**
- **ECS Fargate** service behind an **ALB** with **HTTPS**
- SSL certificate issued via **ACM** and validated through **Route 53**
- **GitHub Actions** workflows for:
  - Docker image build & push
  - Terraform plan, apply, and destroy

---

## Project Structure

```
./
├── .github/
│   └── workflows/
│       ├── apply.yaml
│       ├── destroy.yaml
│       ├── docker.yaml
│       └── plan.yaml
│
├── app/
│   └── dockerfile
│
└── Terraform/
    ├── main.tf
    ├── provider.tf
    ├── variables.tf
    └── modules/
        ├── acm/
        ├── alb/
        ├── ecs/
        ├── route53/
        └── vpc/

```
---

## Local app setup 💻

```bash
yarn install
yarn build
yarn global add serve
serve -s build

Then visit:
http://localhost:3000/workspaces/default/dashboard

Or use:
yarn global add serve
serve -s build
```
---

## Key Components

### Docker
- The `Dockerfile` in the **app/** directory defines how the application is packaged into a container.
- This ensures the app runs consistently across any environment — locally, in testing, or in production.


### Terraform (Infrastructure as Code)
- **ECS Fargate** – Runs the containerised application without managing servers.
- **Application Load Balancer (ALB)** – Distributes incoming web traffic to the ECS service securely over HTTPS.
- **Route 53** – Manages the domain and DNS records for the deployed application.
- **ACM (AWS Certificate Manager)** – Issues and manages SSL certificates for encrypted connections.
- **Security Groups** – Act as virtual firewalls to control inbound and outbound traffic.
- **VPC (Virtual Private Cloud)** – Provides a secure, isolated network for all AWS resources.
- **Remote State (S3 + DynamoDB)** – Stores Terraform state files securely, ensuring changes are tracked and deployments remain consistent.

### CI/CD (GitHub Actions)
- **Docker workflow** – Builds, scans, and uploads Docker images to Amazon ECR.
- **ECR workflow** – Handles pushing container images to AWS Elastic Container Registry.
- **Terraform workflows** – Automate the process of planning, applying, and destroying AWS infrastructure.
- This automation ensures deployments are consistent, repeatable, and require minimal manual intervention.

### Deployment Workflow

1. **Docker Build and Push**
   - Builds the Docker image for the app.  
   - Runs a security scan using Trivy.  
   - Pushes the image to Amazon ECR.

2. **Terraform Plan**
   - Initializes Terraform and generates an execution plan (`terraform plan`).  
   - Validates configuration and performs a security scan with TFLint and Checkov.

3. **Terraform Apply**
   - Deploys all infrastructure: ECS Fargate service, Load Balancer, Route 53 records, and SSL certificate.  
   - Automatically connects components and provisions resources in the correct order.

4. **Terraform Destroy**
   - Safely removes all Terraform-managed AWS resources when no longer needed, ensuring a clean environment.
