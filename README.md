# docker-tuna-setup

用于快速配置 Docker 使用清华大学镜像源的自动化脚本。该脚本支持 Debian/Ubuntu、Fedora、CentOS/RHEL 等发行版。

## 功能

- 自动检测当前 Linux 发行版并配置相应的 Docker 镜像源。
- 支持 Debian/Ubuntu、Fedora、CentOS/RHEL 系统。
- 采用清华大学开源软件镜像站加速 Docker 软件包的下载和安装。

## 支持的系统

- Debian/Ubuntu
- Fedora
- CentOS/RHEL

## 使用方法

### 1. 克隆仓库
```bash
git clone https://github.com/yourusername/docker-tuna-setup.git
cd docker-tuna-setup
```

### 2. 赋予脚本执行权限
```bash
chmod +x setup_docker.sh
```

### 3. 运行脚本
```bash
sudo ./setup_docker.sh
```

运行脚本后，Docker 将被安装并配置为使用清华大学的镜像源。

## 注意事项

- 该脚本将尝试自动删除系统上已安装的旧版本 Docker，以确保安装新版本时不会发生冲突。
- 请确保使用具有 `sudo` 权限的用户执行脚本。
- 脚本会根据系统发行版自动添加相应的 Docker 镜像源，请确保系统可以访问清华大学的镜像站。

## 清华大学 Docker 镜像源

清华大学开源软件镜像站提供了 Docker CE 软件仓库，适用于 Debian、Ubuntu、Fedora、CentOS/RHEL 等发行版。使用该镜像源可以加快 Docker 软件包的下载速度。

## 许可证

MIT License. 请查看 [LICENSE](LICENSE) 文件获取详细信息。

## 贡献

欢迎提交 issue 和 pull request 来改进本项目。

## 相关链接

- [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/)
- [Docker 官方文档](https://docs.docker.com/)
