- Create Developer-server and create local git repository
- Create Github Repository
- Create Access-Secret key for AWS policies
- Create eks-server and install kubectl and eksctl
```bash
ssh-keygen

aws-configure

eksctl create cluster --name adinath-cluster-914 --region ap-south-1 --version 1.29 --vpc-public-subnets subnet-044c44fef8814b390,subnet-065909e8f402e86a7 --node-type t2.micro --nodes-min 2 --ssh-access --ssh-public-key /root/.ssh/id_rsa.pub
```
- in local git repo add file deploy.yml in .github/workflows
```
name: Deploy to ECR

on: 
  push:
    branches: [ main ]

env:
  ECR_REPOSITORY: eksdeployment
  EKS_CLUSTER_NAME: adinath-cluster-914
  AWS_REGION: ap-south-1

jobs:
  build:
    name: Deployment
    runs-on: ubuntu-latest

    steps:

    - name: Set short commit SHA
      id: commit
      uses: prompt/actions-commit-hash@v2

    - name: Check out code
      uses: actions/checkout@v2

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v1
      with: 
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_KEY }}
        aws-region: ${{ env.AWS_REGION }}

    - name: Set up JDK 14
      uses: actions/setup-java@v1
      with:
        java-version: 14

    - name: Build project with Maven
      run: mvn -B package --file pom.xml

    - name: Login to amazon ECR
      id: login-ecr
      uses: aws-actions/amazon-ecr-login@v1

    - name: Build, tag and Push
      id: build-image
      env:
        ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
        ECR_REPOSITORY: ${{ env.ECR_REPOSITORY }}
        IMAGE_TAG: "latest"
      run: |
        docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
        echo "Pushing image to ECR..."
        docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
        echo "::set-output name=image::$ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG"

    - name: Update kube config
      run: aws eks update-kubeconfig --name $EKS_CLUSTER_NAME --region $AWS_REGION

    - name: Deploy to EKS
      env: 
        ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
        IMAGE_TAG: ${{ steps.commit.outputs.short }}
      run: |
        sudo sed -i.bak "s|DOCKER_IMAGE|$ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG|g" /root/manifests/hello-app-deployment.yaml && \
        kubectl apply -f /root/manifests/hello-app-deployment.yaml
        kubectl apply -f /root/manifests/hello-app-service.yaml
```
