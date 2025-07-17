# DevSecOps Course Labs

The hands on labs in this course are completely optional, but highly recommended.
There is no better way to understand how this works in further detail than to try.

## Getting Started

These are great software tools to install on your personal computer to get the best hands on experience doing the work of a DevSecOps Engineer.

### Docker Desktop

Windows
<a>https://docs.docker.com/desktop/setup/install/windows-install/</a>

MAC
<a>https://docs.docker.com/desktop/setup/install/mac-install/</a>

### Visual Studio Code

<a>https://code.visualstudio.com/download</a>

### Windows Subsystem for Linux (WSL)

This allows for Windows to use what is called a Linux terminal. It allows for you to run the type of software necessary for the course, and it's the most widely used computer Operating System.

<a>https://learn.microsoft.com/en-us/windows/wsl/install</a>

### MAC

By default, MAC does have a terminal installed, but you need to install a package manager called Homebrew.
<a>https://brew.sh/</a>
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Helm

<a>https://helm.sh/docs/intro/install/</a>

### Create a GitHub account

It's FREE! Also, it's a great way to show off your ability with coding skills to future employers. Many use this to land this first jobs in Software Engineer.

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