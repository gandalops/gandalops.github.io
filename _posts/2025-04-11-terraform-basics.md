---
layout: single
title: "Terraform Journey: From Zero to Launching EC2 on AWS"
date: 2025-04-11
categories: [Terraform, DevSecOps]
tags: [terraform, aws, ec2, iac, devops]
author_profile: true
read_time: true
---

## 🧠 Why I Chose Terraform

Coming from a project management and academic background, I wanted to *actually build things* — infrastructure included. I chose Terraform because:

- It uses **declarative syntax** (easy to reason about)
- It's widely used in DevSecOps teams
- It integrates well with AWS, GitHub Actions, Jenkins, and more

---

## 🛠️ What I Learned

### ✅ Key Concepts

- **Providers**: I used the `aws` provider to define where Terraform should create infra  
- **Resources**: Defined `aws_instance` to launch EC2  
- **State**: Learned how Terraform tracks infrastructure with `.tfstate`  
- **Plan & Apply**: Got comfortable with `terraform plan` and `terraform apply`  
- **Dependencies**: Understood how Terraform handles creation order internally  

---

## 🔧 Hands-On Example: EC2 with Key Pair

I created a simple EC2 instance using this setup:

- VPC → Subnet → Internet Gateway → Route Table  
- Security Group with `from_port` and `to_port`  
- Connected using `.pem` key file  
- Used `terraform output` to get public IP for SSH access  

```hcl
resource "aws_instance" "my_ec2" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
  key_name      = "ninja"
  tags = {
    Name = "Terraform EC2"
  }
}



🚧 Challenges I Faced & How I Solved Them
🛑 SSH Not Working
Issue: I opened only from_port = 22, forgot to_port = 22.
Fix: Updated security group to include both.
Learning: AWS needs a full range even for a single port. Terraform makes this explicit.

🛑 State File Confusion
Issue: I deleted .tfstate thinking it was cache.
Fix: Researched and restored the state file.
Learning: .tfstate is Terraform’s memory of deployed infra — it’s critical.

🛑 EC2 Not Accessible
Issue: Instance launched, but I couldn't SSH.
Fix: My security group only allowed internal access (10.0.0.0/8). Changed to 0.0.0.0/0 for public testing.
Learning: CIDR ranges define network exposure — must be handled carefully in production.

✅ What’s Next
Configure remote backend using S3 + DynamoDB for state management and locking

Create modular, reusable Terraform code

Build CI/CD pipeline with Jenkins

Integrate Trivy and tfsec for IaC security

Explore Terraform Cloud & Sentinel policies

🔗 GitHub Repository
👉 View the Code on GitHub (Developer Account)

📌 This repo is hosted under my developer account (devyogi7579) where I experiment and learn.
All production-grade automation, pipelines, and CI/CD work is handled from my admin account (gandalops) — just like real-world DevSecOps workflows.

💬 Final Thoughts
Terraform gave me the confidence to move from theory to real infrastructure. Every time I apply, I feel like I’m building something concrete. That’s powerful.

If you're starting out — break it into Epics.
Make it real.
Make it repeatable.

Thank you for reading this article! 😊
If you have any questions, feel free to reach out — I'm happy to connect.

