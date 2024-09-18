## host EKS CLUSTER 

### Prerequisites
- create iam role and attach policy
- ECRfull access,EKSpolicy and IAM full access
  
- apt-get update -y
- apt install unzip -y
- curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
- unzip awscliv2.zip
- sudo ./aws/install
  
- aws configure (add user with admin access policy)
  
### Install EKS Tool
- curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  
- sudo mv /tmp/eksctl /usr/local/bin
- eksctl version

### Install Kubectl
- curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
- sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl 
- kubectl version --client

### Create EKS Cluster
- eksctl create cluster --name adinath-cluster --region ap-south-1 --version 1.29 --vpc-public-subnets subnet-088d3cdb43e2fe46f,subnet-065909e8f402e86a7 --without-nodegroup

### Create ssh-key
- ssh-keygen
  
### Create a Node Group
 eksctl create nodegroup \
  --cluster adinath-cluster \
  --region ap-south-1 \
  --name my-node-group \
  --node-ami-family Ubuntu2004 \
  --node-type t2.small \
  --subnet-ids subnet-088d3cdb43e2fe46f,subnet-065909e8f402e86a7 \
  --nodes 3 \
  --nodes-min 2 \
  --nodes-max 4 \
  --ssh-access \
  --ssh-public-key /root/.ssh/id_rsa.pub




 ### When You want to delete cluster
 eksctl delete cluster --name adinath-cluster



 ### Create one EC2 instance for pushing image on ECR
 - install aws-cli
   
    ```bash
    yum install unzip -y
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    ```
 - install docker

   ```bash
   yum install docker -y
   docker info
   systemctl start docker
   systemctl enable docker
   docker info
   ```
 - Create one image using below script
   
   ```
   FROM ubuntu:22.04
   RUN apt-get update && apt-get install -y apache2
   RUN apt-get install -y tree openssh-server openssh-client
   RUN cd /var/www/html
   RUN echo "Welcome to Devops" > /var/www/html/index.html
   RUN service apache2 start
   ```
 - create one Elastic Container Registry in AWS account >> view push commands >> implement all commands

### pull images from already created cluster inside deployment
- vim ecr-img-deployment.yml
- kubectl apply -f ecr-img-deployment.yml
- kubectl get pods
- kubectl get deployment
- kubectl describe deployment mahek-deployment


### expose image using default service
- kubectl expose deployment <deployment-name> --type=<service-type> --port=<port>
- ex. kubectl expose deployment nginx-deployment --type=NodePort --port=80

### access the deployed service using given port
 
