### Terraform : Infrastructure as a code

Infrastructure as Code (IaC) is a method of managing and provisioning computing infrastructure through machine-readable definition files, rather than through physical hardware configuration or interactive configuration tools

- AWS Cloud : CloudFormation / CloudForm
- Azure : ARM Template
- GCP : Google Deployment
- Private Cloud (OpenStack) : Heat Template

## Save resources and Utilize resources efficiently

- Micheal Hashi : Founder of terraform
- Simple Plain Text : HCL(Hashikorf Configuration Language)
- Terraform, Kubernetes are developed in Golang, Jenkins developed in Java

### Three types of IaC 
1. Configuration Management Tool >> Configures application on the server > Ansible, Puppet, SaltStack, Chef
2. Server Templating Tool >> Make Template of running Server for backup > AWS cli, Docker, Packer, Vagrant
3. Infrastucture Provisioning Tool >> define and provision infrastructures accross various cloud providers using declarative language like yaml, hcl > Terraform, AWS CloudFormation, Azure Resource Manager (ARM), Google Cloud Deployment Manager

.tf >> template file

### different ways to connect terraform instance with aws
1. aws configure
2. aws provider

--------------------------------------------------------------------------------------------------------------

1. Install terraform
	- sudo yum install -y yum-utils
	- sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
	- sudo yum install terraform -y

2. Connect terraform server to cloud (aws) using AWS Provider of AWS configure
3. Initialize Terraform
4. create aws instance using terraform

```
provider "aws" {
  region  = "ap-south-1"
  access_key = "aws_access_key"
  secret_key = "aws_secret_key"
}

resource "aws_instance" "Dev_server" {
  ami           = "ami-08718895af4dfa033"
  instance_type = "t2.micro"
  key           = "trf-kp"
}
```
5. Validate Terraform
6. Plan Terraform
7. Apply Terraform

terraform init >> terraform validate >> terraform plan >> terraform apply

8. enable SSH in security group







