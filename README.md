# Containerised Threat Modelling Tool on AWS ECS Fargate

## Overview

This project deploys a containerised Threat Composer application on **AWS ECS Fargate** using **Terraform**, with the deployment fully automated through **GitHub Actions**.

The setup was created to **automate the deployment** of the threat modelling tool, eliminating the need to manually create AWS resources by leveraging **Infrastructure as Code (IaC)** using Terraform — just like it would be in a real-world production environment!

## Architecture Diagram

<p align="center">
  <img src="images/architecture diagram.png" style="width:700px"/>
</p>


## Features

- Fully automated infrastructure using **Terraform**
- Docker container pushed to **Amazon ECR**
- **ECS Fargate** service behind an **ALB** with **HTTPS**
- SSL certificate issued via **ACM** and validated through **Route 53**
- **GitHub Actions** workflows for:
  - Docker image build & push
  - Terraform plan, apply, and destroy


## Project Structure

| Path | Description |
|------|--------------|
| `app/` | Contains the Dockerised Threat Composer application |
| `app/Dockerfile` | Defines the container image configuration |
| `terraform/` | Main Terraform configuration directory |
| `terraform/main.tf` | Entry point for all Terraform resources |
| `terraform/provider.tf` | Defines AWS provider setup |
| `terraform/variables.tf` | Stores all variable definitions |
| `terraform/modules/` | Contains modularised Terraform configurations |
| `terraform/modules/acm/` | Manages SSL certificate creation via ACM |
| `terraform/modules/alb/` | Configures Application Load Balancer |
| `terraform/modules/ecs_fargate/` | Deploys ECS Fargate service and task definitions |
| `terraform/modules/iam/` | Manages IAM roles and policies |
| `terraform/modules/route53/` | Handles DNS records and validation |
| `terraform/modules/security_groups/` | Defines inbound and outbound rules |
| `terraform/modules/vpc/` | Creates the VPC, subnets, and networking setup |
| `.github/workflows/` | Contains GitHub Actions workflows for CI/CD |
| `.github/workflows/docker.yml` | Builds and pushes Docker image to ECR |
| `.github/workflows/plan.yml` | Runs `terraform plan` on pull requests |
| `.github/workflows/apply.yml` | Applies Terraform configuration to AWS |
| `.github/workflows/destroy.yml` | Destroys infrastructure safely |
