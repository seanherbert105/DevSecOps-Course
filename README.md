## Hands-On Labs (Highly Recommended)
The hands-on labs in this course are **completely optional**, but they are **strongly recommended**.

Reading and watching videos can build awareness, but **doing the work yourself** is the fastest and most effective way to truly understand DevSecOps concepts. These labs are designed to help you:
- Build real-world skills
- Gain confidence using industry-standard tools
- Understand how systems work together in practice
- Learn how DevSecOps engineers solve real problems

If you want to get the **most value** from this course, completing the labs is highly encouraged.

---

## Getting Started
Below are the recommended tools to install on your personal computer to get the **best hands-on learning experience**. These are widely used across the DevSecOps industry and will help prepare you for real-world environments.

---

## Required / Recommended Software

### Docker Desktop

Docker allows you to run applications in containers, which is a core skill for DevSecOps engineers.

**Install Docker Desktop for your operating system:**

- **Windows:**  
  https://docs.docker.com/desktop/setup/install/windows-install/

- **macOS:**  
  https://docs.docker.com/desktop/setup/install/mac-install/

> Tip: Docker Desktop includes Kubernetes, which may be used later in the course.

---

### Visual Studio Code (VS Code)
Visual Studio Code is a lightweight but powerful code editor used throughout the industry.

It will be used for:
- Writing code and configuration files
- Editing YAML and Terraform files
- Working with Git repositories
- Interacting with containers and Kubernetes

**Download:**  
https://code.visualstudio.com/download

---

### Windows Subsystem for Linux (WSL) — *Windows Users Only*
WSL allows Windows to run a **Linux terminal environment**, which is essential for many DevSecOps tools.

Why WSL matters:
- Most DevOps tooling is designed for Linux
- Matches production environments more closely
- Eliminates many compatibility issues on Windows

**Install WSL:**  
https://learn.microsoft.com/en-us/windows/wsl/install

> Recommended distribution: **Ubuntu (latest version)**

---

### macOS Terminal & Homebrew — *macOS Users Only*

macOS includes a built-in terminal by default. However, you will need a package manager called **Homebrew** to easily install development tools.

**Install Homebrew:**
https://brew.sh/

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Helm
Helm is the package manager for Kubernetes. It simplifies deploying and managing applications in a Kubernetes cluster.

Helm will be used in later labs to:

Deploy applications

Manage Kubernetes configurations

Work with industry-standard charts

Installation instructions:
<a>https://helm.sh/docs/intro/install/</a>

### Create a GitHub account
A GitHub account is required for this course.

Why GitHub matters:

Hosts your code and configurations

Tracks your progress over time

Demonstrates your skills to future employers

Used by nearly every DevSecOps and software team

GitHub is free and widely recognized in the industry.

Create an account:
<a>https://www.github.com</a>

## Lab 1 - Running your first container

This command will get you started by deploying an NGINX webserver
```
docker container run --name nginx-example -d -p 80:80 nginx:1.27.5
```

This command will execute a container to run with the name of nginx-example in a detached state (meaning as a background process on your computer), the port exposed will be HTTP port 80, and will be using the nginx container image version 1.27.5.

Once completed, run the following command to stop the container from running. 
```
docker container stop nginx-example
```

After, run the following command to remove the container on your laptop.
```
docker container rm nginx-example
```

## Lab 2 - Create your first developer tokens to run a CI/CD pipeline

### Additional Assistance
<a>https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens</a>

1. Fork the repository on DevSecOps-Course which will create your own working copy. 
2. Go under settings
3. Go under developer settings
4. Generate new token (classic)
5. Give full permissions to the following components
    - repo
    - workflow
    - write:packages

### Additional Assistance
<a>https://docs.github.com/en/actions/how-tos/writing-workflows/choosing-what-your-workflow-does/using-secrets-in-github-actions</a>

After the tokens are created, in order to run CI/CD pipelines using my existing GitHub Actions workflows, you need to copy and paste your newly generated token as a secret. 
1. Create a new repository secret under Actions secrets and variables
2. Name the secret REGISTRY_TOKEN (or else the pipeline will break)
3. Paste the value of the newly generated token in the previous steps

## Lab 3 - Running your first container orchestration

This one will be really short, but essentially run the following command to deploy the voting application using the following docker-compose.yml file given within the root file directory. 

First, login to your ghcr.io registry, you will be prompted for a username and password, insert the value of the newly generated token you created in the previous lab.
```
docker login ghcr.io
```

Then run the container using the following command.
```
docker compose up --detach
```

If you recieve an error, make sure you're within the DevSecOps-Course directory.

## Lab 4 - Deploying a Department of Defense Software Factory

There will be minimal instructions on how to perform this and will be taught alongside the instructor. 

First, setup ArgoCD to be installed.
```
kubectl create namespace argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

Then install ArgoCD using Helm.
```
helm upgrade --install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  --set server.service.type=NodePort
```

Run the following command to get your default login password, username is admin.
```
echo && kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo
```

Run the following command to find your NodePort that ArgoCD is running on. The command will find the service under the deployed namespace that ArgoCD is under.
```
kubectl get svc -n argocd
```

In order to access the Voting App, you need to install what is called an ingress controller. NGINX is the most popular and widely used.
```
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace
```

From here, we will access our ArgoCD and follow the remainder of the instructions.