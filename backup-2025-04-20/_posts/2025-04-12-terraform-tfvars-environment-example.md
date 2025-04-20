---
layout: single
title: "Understanding `.tfvars` in Terraform with Real EC2 Example"
date: 2025-04-12
tags: [Terraform, DevSecOps, AWS, Best Practices]
categories: [Terraform]
description: A practical deep dive into `.tfvars` usage in Terraform, with EC2 deployment examples and industry-aligned best practices.
toc: true
toc_sticky: true
toc_label: "Article Contents"
---

## ✅ What I Learned Today

Today, I focused on one of the most fundamental, yet often misunderstood features in Terraform: **the use of `.tfvars` files**. I explored it with hands-on EC2 deployment and captured the Terraform behavior clearly.

---

## 🧠 Key Concepts Covered

- How `.tfvars` overrides `variables.tf`
- Real difference when changing EC2 `instance_type`
- When to use `.tfvars` and what to include in it
- Best practices to avoid pushing `.tfvars` to Git

---

## 🔨 What I Did

### 1 Initial Setup

I created the following files inside a Terraform project:

```hcl
# variables.tf
variable "instance_type" {
  default = "t2.micro"
}

# terraform.tfvars
instance_type = "t3.micro"

# main.tf
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  ...
}

2 Observing Terraform Behavior
When I ran terraform plan, it showed:
~ instance_type = "t2.micro" -> "t3.micro"
-/+ will be replaced
Meaning: EC2 instance is immutable on instance_type change, so Terraform will destroy and recreate it.

3 Real-World Learning
-   I noticed if I restart the EC2 manually from AWS Console, Terraform detects public IP changes even if infra wasn't changed in code.
-   If .tfvars has values, Terraform will always use them instead of variables.tf defaults.
-   Variable Precedence Order (High → Low): CLI -var flag > CLI -var-file flag > terraform.tfvars file > *.auto.tfvars files > Environment variables > Default in variables.tf

📁 Folder Structure
    tf-infra-ec2/
    ├── main.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── outputs.tf
    ├── terraform.tfstate

✅ Best Practices I Followed

    - Keep .tfvars local and do not push to Git
    - Use .tfvars.example in repo for team reference
    - Override environment-specific values in .tfvars only
    - Use terraform plan -var-file="dev.tfvars" in multi-env setups

🧪 Key Commands Used

    - terraform init
    - terraform plan -out=plan.out
    - terraform apply "plan.out"
    - terraform show

📚 My Takeaway
    Understanding .tfvars gives you confidence in clean separation of code vs config in Terraform. It’s a best practice that ensures clarity, reusability, and secure deployments in real teams and environments.

🚀 Next Step
    I’ll now create a new subproject using dev.tfvars and prod.tfvars to simulate multi-environment deployment.

    Stay tuned & Happy reading...