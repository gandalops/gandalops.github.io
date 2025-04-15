---
layout: single
title: "Governance & Policy as Code: My DevSecOps Operating System"
date: 2025-04-15
last_modified_at: 2025-04-15
categories: [DevSecOps, Governance]
tags: [terraform, opa, tfsec, governance, devsecops, policy-as-code]
excerpt: "How I apply real-world governance rules, policy enforcement, and security practices across all 21 DevSecOps Epics."
author_profile: true
read_time: true
toc: true
toc_sticky: true
toc_label: "Article Contents"
---

# 🔐 DevSecOps Governance Tools Comparison

As a DevSecOps practitioner, it's critical to choose the right Policy-as-Code tool based on your stack and use case. Below is a comparison of 5 key tools used to enforce governance across CI/CD pipelines, Infrastructure as Code, and Kubernetes.

## 📊 Tool Overview Table

| Tool       | Ecosystem Fit                 | Policy Language     | Best For                              | Realtime Enforcement | Difficulty |
|------------|-------------------------------|---------------------|----------------------------------------|-----------------------|------------|
| OPA        | Cloud-native (K8s, Terraform) | Rego                | Generic policy engine, APIs, Terraform | ✅ Yes (via Gatekeeper) | ⚙️ Medium |
| Sentinel   | HashiCorp Stack               | Sentinel (HCL-like) | Terraform Enterprise, Vault, Consul    | ✅ Yes                 | ⚙️ Medium |
| Checkov    | Terraform, CloudFormation     | YAML + Python       | IaC static security checks             | ❌ No (pre-apply only) | 🟢 Easy   |
| Conftest   | YAML, JSON, Dockerfiles, etc. | Rego (OPA)          | CI/CD config validation                | ❌ No (CI only)        | ⚙️ Medium |
| Kyverno    | Kubernetes-native             | Declarative YAML    | Kubernetes admission policies          | ✅ Yes                 | 🟢 Easy   |

## 🛠 Real-World Use Cases

### ✅ OPA (Open Policy Agent)
- Enforce no unencrypted S3 buckets in Terraform
- Block Kubernetes pods from running as root (via Gatekeeper)
- Apply policies on custom APIs (Envoy/NGINX integration)

```rego
# Example: Disallow root containers in Kubernetes
violation[{"msg": msg}] {
  input.spec.securityContext.runAsNonRoot == false
  msg := "Containers must not run as root"
}
```

### ✅ Sentinel
- Block Terraform plans that don't tag resources
- Ensure secrets in Vault are not readable by unauthorized teams
- Enforce different access levels in Nomad jobs

```hcl
# Example: Enforce tags in Terraform
main = rule { all resources.r as r { r.tags contains "env" } }
```

### ✅ Checkov
- Scan IaC for overexposed security groups
- Validate if RDS databases have backup retention
- Catch hardcoded secrets in Terraform

```yaml
# Checkov result example
check: CKV_AWS_24
message: Ensure no open security group to 0.0.0.0/0
```

### ✅ Conftest
- Validate Ansible playbooks for required variables
- Enforce naming conventions in GitHub Actions workflows
- Integrate into Jenkins CI to block invalid config commits

```rego
# Example: Validate that env is defined
deny[msg] {
  not input.env
  msg := "Missing required env key"
}
```

### ✅ Kyverno
- Prevent using the `latest` image tag
- Auto-label all pods with team name
- Require resource requests & limits on every deployment

```yaml
# Example: Block latest image tag
spec:
  validation:
    message: "Avoid using latest tag"
    pattern:
      spec:
        containers:
        - image: "!*:latest"
```

## 🧠 Summary: How to Choose

| Scenario                                | Start With     |
|-----------------------------------------|----------------|
| General-purpose policies                | OPA            |
| You use Terraform Enterprise            | Sentinel       |
| Quick IaC scan before deploying         | Checkov        |
| Need portable CI/CD policy checks       | Conftest       |
| Kubernetes native enforcement           | Kyverno        |

---

## 🔗 Explore More:
- [https://www.openpolicyagent.org/](https://www.openpolicyagent.org/)
- [https://developer.hashicorp.com/sentinel](https://developer.hashicorp.com/sentinel)
- [https://www.checkov.io/](https://www.checkov.io/)
- [https://www.conftest.dev/](https://www.conftest.dev/)
- [https://kyverno.io/](https://kyverno.io/)

---

*Thanks for reading. May your pipelines be green, your infra be tagged, and your security posture be strong!*

🔗 Explore my projects, policies, and pipelines on [opsbygandal.dev](https://www.opsbygandal.dev)  \
or on on github link [https://github.com/gandalops?tab=repositories](https://github.com/gandalops?tab=repositories)
🔄 Feedback? Let’s connect on [LinkedIn](https://www.linkedin.com/)