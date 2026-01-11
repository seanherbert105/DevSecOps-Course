# Getting Started with Terraform

This repository contains Terraform Infrastructure as Code (IaC) templates.  
Terraform allows you to **define, deploy, and manage infrastructure using code**, instead of manually clicking through web consoles.

This guide is written for **first-time Terraform users** and will walk you through:
- What Terraform is and how it works
- How to install and configure it
- How to safely run Terraform commands
- How Terraform manages infrastructure state
- Common pitfalls and best practices

---

## What Is Terraform?

Terraform is an **Infrastructure as Code (IaC)** tool created by HashiCorp.

With Terraform, you:
- Write infrastructure definitions in `.tf` files
- Describe *what you want*, not *how to build it*
- Let Terraform calculate and apply the required changes

Terraform can manage:
- Cloud infrastructure (AWS, Azure, GCP)
- Kubernetes resources
- Databases
- Networking
- SaaS platforms (GitHub, Datadog, Vault, etc.)

---

## Key Terraform Concepts (Beginner Friendly)

### Providers
A **provider** is a plugin that allows Terraform to talk to an external API.

Examples:
- `aws` → Amazon Web Services
- `azurerm` → Microsoft Azure
- `google` → Google Cloud Platform
- `kubernetes` → Kubernetes clusters

Providers are automatically downloaded during `terraform init`.

---

### Resources
A **resource** represents something Terraform creates or manages.

Examples:
- A virtual machine
- A cloud storage bucket
- A Kubernetes namespace
- A firewall rule

Resources are defined in `.tf` files.

---

### State
Terraform keeps track of what it manages using a **state file**.

The state file:
- Maps real infrastructure to Terraform resources
- Helps Terraform understand what already exists
- Is **critical** and should be protected

**Never manually edit a Terraform state file.**

---

### Backend
A **backend** defines *where Terraform stores its state*.

Common backends:
- Local file (default, not recommended for teams)
- AWS S3
- Azure Storage Account
- Google Cloud Storage
- Terraform Cloud / Enterprise

Using a backend:
- Enables collaboration
- Prevents multiple people from breaking infrastructure
- Supports state locking

---

## Official Terraform Resources

### Terraform Documentation
https://developer.hashicorp.com/terraform

Use this for:
- Installing Terraform
- Understanding Terraform language syntax
- Learning Terraform commands
- Best practices and examples

HashiCorp documentation is considered the **source of truth**.

---

### Terraform Registry
https://registry.terraform.io/?product_intent=terraform

The Terraform Registry contains:
- Providers
- Modules
- Resource documentation
- Usage examples

When in doubt about how to configure a resource, **check the Registry first**.

---

## Prerequisites

Before running Terraform, ensure you have:

1. **Terraform installed**
```
terraform -version
```
```
terraform init
```

What this does:
- Downloads required providers
- Configures the backend
- Prepares Terraform to run

You must run this:
- The first time you clone the repo
- Any time provider versions or backend settings change

```
terraform plan
```

What this does:
- Checks for syntax errors
- Compares desired configuration vs existing infrastructure
- Shows what will be created, modified, or destroyed

Best practice:
- Always review the plan before applying changes.
- Apply your Terraform code.

```
terraform apply
```

What this does:
- Re-runs the plan
- Prompts for confirmation
- Makes actual changes to infrastructure

Destroy everything.
```
terraform destroy
```

What this does:
- Deletes everything Terraform created
- Useful for temporary environments (labs, testing)

This is irreversible.
Always double-check what you are destroying.