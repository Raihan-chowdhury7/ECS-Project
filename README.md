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
