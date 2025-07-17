# Getting Started with Terraform
This will be just enough information to get started working with Terraform.

### Terraform Documentation
<a>https://developer.hashicorp.com/terraform</a>

Reference here for any Terraform commands, how to install Terraform, and other how-to-guides. HashiCorp does very well in writing documentation.

### Terraform Registry
<a>https://registry.terraform.io/?product_intent=terraform</a>

Reference here to work with a variety of Terraform resource providers. This can be cloud services (AWS, Azure, GCP) or other software such as Kubernetes.

### Run this Terraform template

Create a backend for Terraform to use, this helps with tracking IaC states. 
```
terraform init
```

Check for code errors.
```
terraform plan
```

Apply your Terraform code.
```
terraform apply
```

Destroy everything.
```
terraform destroy
```