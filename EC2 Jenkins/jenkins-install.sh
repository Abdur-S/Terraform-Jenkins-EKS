#!/bin/bash
set -e

echo "Updating system..."
sudo yum update -y || sudo dnf update -y

# ------------------------------------------------
# Install Java 17 (Jenkins requirement)
# ------------------------------------------------
if command -v amazon-linux-extras &> /dev/null; then
    # Amazon Linux 2
    sudo amazon-linux-extras enable corretto17
    sudo yum install -y java-17-amazon-corretto
else
    # Amazon Linux 2023
    sudo dnf install -y java-17-amazon-corretto
fi

# ------------------------------------------------
# Install Jenkins (Latest Stable)
# ------------------------------------------------
echo "Installing Jenkins..."

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum install -y jenkins || sudo dnf install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

# ------------------------------------------------
# Install Git
# ------------------------------------------------
sudo yum install -y git || sudo dnf install -y git

# ------------------------------------------------
# Install Terraform (Latest Stable)
# ------------------------------------------------
echo "Installing Terraform..."

sudo yum install -y yum-utils || sudo dnf install -y yum-utils

sudo yum-config-manager --add-repo \
    https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

sudo yum install -y terraform || sudo dnf install -y terraform

# ------------------------------------------------
# Install kubectl (Latest Stable Dynamically)
# ------------------------------------------------
echo "Installing kubectl..."

KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# ------------------------------------------------
# Verify Versions
# ------------------------------------------------
echo "Java:"
java -version

echo "Jenkins:"
sudo systemctl status jenkins --no-pager

echo "Terraform:"
terraform -version

echo "kubectl:"
kubectl version --client

echo "Setup completed successfully!"
