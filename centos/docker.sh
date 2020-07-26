#!/bin/bash

# doc: https://docs.docker.com/engine/install/centos/

echo "begin install docker..."

# uninstall old version
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine

# Install using the repository
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum update -y

sudo wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm

sudo yum -y install ./containerd.io-1.2.6-3.3.el7.x86_64.rpm

sudo yum install -y docker-ce docker-ce-cli

sudo systemctl start docker

sudo systemctl enable docker

dockerVersion=`docker -v`
echo "docker version: $dockerVersion"

# echo "begin install docker-compose..."

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

latestVersion=`get_latest_release "docker/compose"`
echo "docker-compose version: $latestVersion"

sudo curl -L "https://github.com/docker/compose/releases/download/$latestVersion/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

echo "all done!"
