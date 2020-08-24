#!/bin/bash

# doc: https://docs.docker.com/engine/install/centos/

echo "begin install docker..."

# uninstall old version
yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine

# Install using the repository
# 官方镜像：https://download.docker.com/linux/centos/docker-ce.repo
#建议使用阿里云的镜像进行加速，要不太慢了
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo 

yum update -y

#wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm

yum -y install ./containerd.io-1.2.6-3.3.el7.x86_64.rpm

yum install -y docker-ce docker-ce-cli

systemctl start docker

systemctl enable docker

# dockerVersion=`docker -v`
# echo "docker version: $dockerVersion"

echo "begin install docker-compose..."

# get_latest_release() {
#   curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
#     grep '"tag_name":' |                                            # Get tag line
#     sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
# }

# latestVersion=`get_latest_release "docker/compose"`
# echo "docker-compose version: $latestVersion"

# curl -L "https://github.com/docker/compose/releases/download/$latestVersion/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

cp docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "all done!"
