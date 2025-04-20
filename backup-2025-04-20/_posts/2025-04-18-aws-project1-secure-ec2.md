---
layout: single
title: "AWS Project 1: Launching a Secure, Monitorable EC2 — My First DevSecOps Lab"
date: 2025-04-18
last_modified_at: 2025-04-18
categories: [DevSecOps, AWS]
tags: [aws, ec2, vpc, secretsmanager, cloudwatch, devsecops, monitoring, iam]
excerpt: "My hands-on DevSecOps journey of creating a secure and monitorable EC2 environment in AWS, with IAM, Secrets Manager, CloudWatch, CloudTrail, and cleanup."
author_profile: true
read_time: true
toc: true
toc_sticky: true
toc_label: "Article Contents"
---

## 🔶 Today’s AWS Hands-On (Project 1 – DevSecOps Epic)

As part of my **AWS Epic** on the DevSecOps learning journey, today’s goal was to complete **Project 1: Launch a Secure, Monitorable EC2 in a Custom VPC** — fully hands-on via the AWS Console, without Terraform or automation.

---

## 🚩 Problem Statement

> I wanted to understand how to manually create a secure, production-ready EC2 environment in AWS — not just spinning up a VM, but including all **networking**, **IAM roles**, **secret access**, and **monitoring/logging** using best practices.

---

## ✅ What I Built

Here’s what I manually created and tested, step by step:

### 🔹 Networking
- Created a custom VPC, subnet, internet gateway, and route table.
- Enabled auto-assign public IP and VPC Flow Logs to CloudWatch.

### ⚙️ EC2 Setup
- Created an IAM role with least privilege (SSM + Secrets access).
- Generated a secure SSH key pair and launched a t2.micro EC2.
- Connected to the instance using SSH and validated instance metadata.

### 🔐 Secret Management
- Stored a secure DB password in AWS Secrets Manager.
- Accessed it from EC2 using AWS CLI — no hardcoded credentials.

### 📊 Monitoring & Alerting
- Installed CloudWatch Agent to monitor CPU, memory, disk.
- Created a CloudWatch Alarm (CPU > 10%) and tested using stress tool.
- Received email alert via SNS — confirmed observability.

### 📜 Audit & Governance
- Enabled CloudTrail to log all API activity into an S3 bucket.
- Ran IAM Access Analyzer to detect any public or cross-account access.
- Verified that all configurations followed DevSecOps governance principles.

---

## 🌱 What I Learned

This project taught me more than I expected:

- The **difference between launching EC2** and **designing secure infrastructure**
- How to apply **IAM roles, secret access, and monitoring** like a professional
- That **CloudTrail, Flow Logs, and Access Analyzer** help in governance and visibility
- Importance of **verifying every step** — from access to logging

This wasn't just a hands-on; it was a lesson in building **secure, observable, and auditable infrastructure** — exactly what DevSecOps is about.

---

## 🧠 Final Reflection

> This wasn’t just a cloud lab. It was a mindset shift — from “click and launch” to “design, secure, monitor, and delete.”

By the end of this project, I wasn’t just running an EC2 instance.  
I was **running a secured workload** with IAM, secrets, metrics, logs, and alerting — and then responsibly **cleaned everything up**.

---

## 🧹 Cleanup Checklist

- ✅ Terminated EC2 instance
- ✅ Deleted IAM roles and secrets
- ✅ Removed CloudTrail trail and S3 bucket
- ✅ Deleted VPC, subnet, IGW, and route table
- ✅ Disabled Flow Logs and deleted log groups
- ✅ Deleted SSH key pair and local `.pem` file

---

*Thanks for reading. May your pipelines be green, your infra be tagged, and your security posture be strong!*

🔗 Explore my projects, policies, and pipelines on [opsbygandal.dev](https://www.opsbygandal.dev)  \
or on GitHub: [https://github.com/gandalops?tab=repositories](https://github.com/gandalops?tab=repositories)  
🔄 Feedback? Let’s connect on [LinkedIn](https://www.linkedin.com/)
```

---
