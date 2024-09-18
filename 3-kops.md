### installing unzipping package
- apt install unzip -y

### installing aws-cli
- curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
- unzip awscliv2.zip
- sudo ./aws/install

### installing kubectl
- curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
- sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
- kubectl version --client

### Setting-up KOPS installation folder
- curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
- chmod +x ./kops
- sudo mv ./kops /usr/local/bin/

### setting root access key
- aws configure
(add access key, security key, and correct zone of route and instance)

### installing kops
- curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
- chmod +x kops-linux-amd64
- sudo mv kops-linux-amd64 /usr/local/bin/kops
- kops version

### Create a Route53 private hosted zone with the same name as s3-bucket

### creating aws s3 bucket 
- aws s3 mb s3://dev.k8s.adinathbucket18.in
- aws s3 ls
- export KOPS_STATE_STORE=s3://dev.k8s.adinathbucket18.in

### generating ssh-key
- ssh-keygen

### creating cluster
- kops create cluster --cloud=aws --zones=ap-south-1a --name=dev.k8s.adinathbucket18.in --dns-zone=adinathbucket23.in --dns private

- kops update cluster dev.k8s.adinathbucket18.in --yes --admin

### validating cluster
- kops validate cluster (wait for 5-10 minutes)

### getting all cluster nodes
- kubectl get nodes

### deploying nginx on pods
- kubectl create deployment sample-nginx --image=nginx

- kubectl scale deployment sample-nginx --replicas=2

- kubectl expose deployment sample-nginx --port=80 --target-port=80 --type=LoadBalancer

### getting all pods information
- kubectl get services -o wide
- kubectl get pods
- kubectl get deployments
- kubectl -n kube-system get po

- kubectl describe pod sample-nginx-5b965d776f-dcpnm

- vim myfirstpod.yml
- kubectl apply -f myfirstpod.yml
  

### Deleteing Cluster
- kops delete cluster dev.k8s.adinathbucket23.in --yes
