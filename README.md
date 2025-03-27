# DevSecOps-class

To conduct the hands on learning portion of this class, you must have some type of Linux OS to work on and Docker. WSL is the recommended method to meet this requirement on Windows and MAC has a terminal installed by default. 

### Install WSL

Follow the instructions below to install WSL on your Windows laptop. 
```
https://learn.microsoft.com/en-us/windows/wsl/install#prerequisites
```

### Install Docker

Follow the instructions below to install Docker Desktop on Windows. or MAC laptop. 
```
https://docs.docker.com/desktop/setup/install/windows-install/
```

Follow the instructions below to install Docker Destop on MAC.
```
https://docs.docker.com/desktop/setup/install/mac-install/
```

### Get started on developing a pipeline

Clone the repository into your /tmp file directory. This directory is being used because by default everything will be deleted once your reboot your computer. 
```
git clone https://github.com/seanherbert105/DevSecOps-class.git
```

Next, go into the bin directory and run the bash script getting-started.sh
```
bash getting-started.sh
```

Now the Jenkins UI should be available on localhost (which is running on your local computer and not accessible to anyone else).
```
http://localhost:8080
```
The login information to jenkins is the following.

Username: admin

Password will be in the following directory within the Docker container. Run the following command to execute a command internal to the Docker container. 
```
docker exec -it jenkins/docker cat /var/jenkins_home/secrets/initialAdminPassword
```


