#!/bin/bash

# 检查系统发行版
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported operating system."
    exit 1
fi

# Debian/Ubuntu 安装方法
setup_debian_ubuntu() {
    echo "Setting up Docker CE for Debian/Ubuntu..."

    # 删除旧版本
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
        apt-get remove -y $pkg
    done

    # 安装依赖
    apt-get update
    apt-get install -y ca-certificates curl gnupg

    # 添加 Docker GPG 公钥
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    # 添加清华镜像源
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    # 安装 Docker
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Fedora 安装方法
setup_fedora() {
    echo "Setting up Docker CE for Fedora..."

    # 删除旧版本
    dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine

    # 安装依赖并添加清华镜像源
    dnf -y install dnf-plugins-core
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sed -i 's+https://download.docker.com+https://mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo

    # 安装 Docker
    dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# CentOS/RHEL 安装方法
setup_centos_rhel() {
    echo "Setting up Docker CE for CentOS/RHEL..."

    # 删除旧版本
    yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

    # 安装依赖并添加清华镜像源
    yum install -y yum-utils
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sed -i 's+https://download.docker.com+https://mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo

    # 安装 Docker
    yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# 根据系统类型执行相应的安装
case "$OS" in
    ubuntu|debian)
        setup_debian_ubuntu
        ;;
    fedora)
        setup_fedora
        ;;
    centos|rhel)
        setup_centos_rhel
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

echo "Docker CE has been installed and configured with Tsinghua University's mirror."
