# Go to home directory (optional)
cd ~
# Create main project folder
mkdir terraform-aws-infra
cd terraform-aws-infra
# Create modules folder (for VPC, EKS modules later)
mkdir modules
# Create VPC module
mkdir modules/vpc
touch modules/vpc/main.tf modules/vpc/variables.tf modules/vpc/outputs.tf
# Create EKS module
mkdir modules/eks
touch modules/eks/main.tf modules/eks/variables.tf modules/eks/outputs.tf
# Go back to main project directory
cd ~/terraform-aws-infra
# Create main Terraform configuration files
touch main.tf provider.tf variables.tf outputs.tf backend.tf terraform.tfvars
ls -R ~/terraform-aws-infra
docker --version
docker-compose --version
kubectl version --client
helm version
aws --version
aws configure
aws sts get-caller-identity
aws configure
aws sts get-caller-identity
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y wget unzip
wget https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_amd64.zip
unzip terraform_1.8.4_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform version
ls -R ~/terraform-aws-infra
ls
cd terraform-aws-infra
ls
terraform init
terraform validate
sudo killall terraform
terraform init
terraform validate
sudo reboot
terraform init
cmd
ls
cd ~/terraform-aws-infra
ls
terraform init
ls
cd modules
ls
cd vpc
ls
terraform fmt
terraform validate
terraform init
cd ~/terraform-aws-infra
terraform init
terraform validate
terraform plan
cd ~/terraform-aws-infra
terraform init
terraform plan
cd ~/terraform-aws-infra
ls
terraform init
terraform plan
git --version
clear
cd ~
git clone https://github.com/hemakshis/Basic-MERN-Stack-App.git
cd Basic-MERN-Stack-App
ls
cd ~
ls
rm -rf Basic-MERN-Stack-App
ls
git clone https://github.com/ed-roh/mern-social-media.git
cd mern-social-media
ls
cd server
nano Dockerfile
Backend Dockerfile created. Ready for frontend Dockerfile
cd ~/mern-social-media/client
nano Dockerfile
cd ~/mern-social-media
vim docker-compose.yml
docker-compose up --build
cd ~/mern-social-media/client/Dockerfile
cd ~/mern-social-media/client
vim Dockerfile
cd ~/mern-social-media
docker-compose build frontend
