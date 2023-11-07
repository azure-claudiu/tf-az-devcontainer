apt-get update

apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg

LSB_DIST=$(lsb_release -cs)

# Install Az CLI

curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /usr/share/keyrings/microsoft.gpg > /dev/null

chmod go+r /usr/share/keyrings/microsoft.gpg

echo "deb [arch=`dpkg --print-architecture` signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $LSB_DIST main" | tee /etc/apt/sources.list.d/azure-cli.list

apt-get update && apt-get install -y azure-cli=$AZ_VER-1~$LSB_DIST

# Install Terraform

curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/hashicorp.gpg --import

chmod 644 /etc/apt/trusted.gpg.d/hashicorp.gpg

echo "deb [signed-by=/etc/apt/trusted.gpg.d/hashicorp.gpg] https://apt.releases.hashicorp.com $LSB_DIST main" | tee /etc/apt/sources.list.d/hashicorp.list

apt update && apt-get install -y terraform=$TF_VER

# Install Kubectl

K8S_VER=$(curl -L -s https://dl.k8s.io/release/stable.txt)

curl -LO "https://dl.k8s.io/release/$K8S_VER/bin/linux/amd64/kubectl"

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

rm kubectl
