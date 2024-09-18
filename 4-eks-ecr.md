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


 
