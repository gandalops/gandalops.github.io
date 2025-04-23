---
layout: single
title: "Securing Terraform with Checkov: My First Governance Hardening Pass"
date: 2025-04-15
last_modified_at: 2025-04-15
categories: [DevSecOps, Governance]
tags: [terraform, checkov, devsecops, security, governance, policy-as-code]
excerpt: "My first hands-on experience applying security policies to Terraform using Checkov. From 11 failed checks to just 3, here’s what I learned."
author_profile: true
toc: true
toc_label: "Article Contents"
toc_sticky: true
---

🔍 **Context:** As part of my DevSecOps learning journey (Epic 21: Governance & Policy as Code), I wanted to enforce security best practices in a live Terraform project. The goal was to use Checkov to scan my Infrastructure as Code (IaC) and apply necessary fixes to improve compliance, visibility, and confidence in what I was deploying.

---

## 🧱 Scenario Before Scan

I began with a basic Terraform setup that provisioned:
- A VPC
- A public subnet
- A security group allowing SSH
- A single EC2 instance with default settings

The infrastructure worked fine functionally, but I had never considered if it followed security best practices. To assess this, I introduced **Checkov** into the workflow using:

```bash
checkov -d .
```

### ❌ Initial Scan Result:
- **Passed Checks**: 9
- **Failed Checks**: 11

### 🚨 Key Risks Detected:
- **SSH open to 0.0.0.0/0**: Meaning anyone could attempt to access the instance.
- **Egress open to all traffic**: This could allow exfiltration or unintended internet communication.
- **Missing `description` on security group rules**: Makes future audits harder.
- **EBS volume not encrypted**: Data could be exposed if snapshot is leaked.
- **CloudWatch monitoring disabled**: No visibility into instance metrics.
- **IMDSv1 allowed**: Exposes risk of metadata credential theft via SSRF.
- **No IAM role for EC2**: Violates least privilege principle.
- **Subnet automatically assigns public IP**: Increases exposure risk.
- **VPC flow logging not enabled**: No way to trace traffic for security reviews.

This was an eye-opener. My infrastructure *worked*, but it was not **safe by design**.

---

## 🔧 Fixes Made (Batch-Wise)

To fix the issues efficiently, I organized changes into 3 batches based on the affected components.

### 🔐 **Batch 1: Security Group Tightening**

- Changed SSH rule to allow only trusted IP (e.g. office/home)
- Limited egress to only HTTPS traffic (port 443)
- Added `description` fields for both ingress and egress rules

These changes directly tackled the over-permissive nature of the security group and improved auditability.

---

### 💾 **Batch 2: EC2 Instance Hardening**

- Enabled CloudWatch detailed monitoring
- Enabled EBS optimization for better IO performance
- Encrypted the EBS root volume
- Enforced usage of IMDSv2 (disables insecure IMDSv1)
- Commented out `iam_instance_profile` line to be added later with least privilege

These enhanced the resilience, observability, and security of the EC2 instance.

---

### 🌐 **Batch 3: Network & VPC Adjustments**

- Disabled `map_public_ip_on_launch` to reduce default exposure
- Deferred VPC flow log implementation (planned as a future lab)

This made the networking layer more controlled and reduced unnecessary exposure to the internet.

---

### 🧪 Terraform Workflow Used

I didn’t want to apply changes blindly, so I used:

```bash
terraform plan -out secure.plan
terraform apply secure.plan
```

This ensures no surprise changes — a must-follow DevSecOps habit!

---

## 📊 After Scan Result

Once I applied the changes and re-ran Checkov:

```bash
checkov -d .
```

### ✅ Final Result:
- **Passed Checks**: 17
- **Failed Checks**: 3

### 🟡 Remaining (Deferred by Design):
- **IAM role missing for EC2**: Will be added in Task 21.5
- **VPC flow logging not enabled**: Scheduled for Task 21.7
- **Default security group too permissive**: Not used in infra, so low-risk

---

## 🧠 Key Learnings

- Policy-as-Code is a *must* — Checkov showed me what I couldn’t see in plain Terraform code.
- Small changes (like IMDSv2 or `description`) have *big impact*.
- Grouping fixes in logical batches helped stay organized and focused.
- Running `terraform plan -out` is now a permanent habit.
- Security is not just about tools — it’s about awareness, design, and decision making.

---

## 📌 What’s Next?

- ✍️ Write a custom OPA policy for unencrypted EBS volumes
- 🔒 Use Checkov to block public S3 buckets in a live test
- 🛡️ Attach IAM role with least privilege to EC2
- 📈 Enable VPC Flow Logs with CloudWatch and IAM
- 📘 Write a blog post for each fix area as a reusable security pattern

---

*Thanks for reading! You can track my progress at **[opsbygandal.dev](https://www.opsbygandal.dev)** or follow me on GitHub **[@gandalops](https://github.com/gandalops)**.*

