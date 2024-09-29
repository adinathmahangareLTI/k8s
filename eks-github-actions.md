- Create Developer-server and create local git repository
- Create Github Repository
- Create Access-Secret key for AWS policies
- Create eks-server and install kubectl and eksctl
```bash
ssh-keygen

aws-configure

eksctl create cluster --name adinath-cluster-914 --region ap-south-1 --version 1.29 --vpc-public-subnets subnet-044c44fef8814b390,subnet-065909e8f402e86a7 --node-type t2.micro --nodes-min 2 --ssh-access --ssh-public-key /root/.ssh/id_rsa.pub
```
